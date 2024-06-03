import {Injectable} from '@nestjs/common';

import {Parser} from 'pickleparser';
import * as path from "node:path";
import * as fs from "fs";
import {ChromaClient} from "chromadb";
import {HuggingFaceService} from "../HF/hf.service";


@Injectable()
export class ChromaService {
    private docs;
    private ids;
    private embeddings;
    private chroma
    private antiqueCollection;
    private lotteCollection;
    private antiqueQueryCollection;
    private lotteQueryCollection;

    constructor(
        private huggingFaceService: HuggingFaceService,
    ) {
    }

    // Antique
    async antiqueInitDocs() {
        this.docs = Object(await this.unPickle("Files/antique/orignal_data.pkl"));
        console.log("Done Reading docs")
    }

    async antiqueInitIds() {
        this.ids = Object(await this.unPickle("Files/antique/data_names.pkl"));
        console.log("Done Reading ids")
    }

    async antiqueInitEmbeddings() {
        this.embeddings = Object(await this.unPickle("Files/antique/embeddings_list.pkl"));
        console.log("Done Reading...")
    }

    async antiqueInit() {
        const batchSize = 1000
        const numDocuments = 403666

        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});

        const antiqueCollection = await this.chroma.getOrCreateCollection({name: "antique"});

        if (await antiqueCollection.count() <= 0)
            for (let i = 0; i < numDocuments; i += batchSize) {
                const batchData = this.docs.slice(i, i + batchSize);
                const batchNames = this.ids.slice(i, i + batchSize);
                const batchEmbeddings = this.embeddings.slice(i, i + batchSize);
                console.log(i)
                await antiqueCollection.add({
                    documents: batchData,
                    ids: batchNames,
                    embeddings: batchEmbeddings
                })

            }
        console.log("Done Init Antique")
    }

    async antiqueSearch(query: string) {
        const query_embeds = await this.huggingFaceService.embedQuery(query)
        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        if(!this.antiqueCollection)
         this.antiqueCollection = await this.chroma.getCollection({name: "antique"});
        return await this.antiqueCollection.query({
            queryEmbeddings: query_embeds,
            nResults: 10
        });
    }


    // Lotte
    async lotteInitDocs() {
        this.docs = Object(await this.unPickle("Files/lotte/lotte_orignal_data.pkl"));
        console.log("Done Reading docs")
    }

    async lotteInitIds() {
        this.ids = Object(await this.unPickle("Files/lotte/data_names.pkl"));
        console.log("Done Reading ids")
    }

    async lotteInitEmbeddings() {
        this.embeddings = Object(await this.unPickle("Files/lotte/Lembeddings_list.pkl"));
        console.log("Done Reading...")
    }

    async lotteInit() {
        const batchSize = 1000
        const numDocuments = 343642

        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});

        const lotteCollection = await this.chroma.getOrCreateCollection({name: "lotte"});

        if (await lotteCollection.count() <= 0)
            for (let i = 0; i < numDocuments; i += batchSize) {
                const batchData = this.docs.slice(i, i + batchSize);
                const batchNames = this.ids.slice(i, i + batchSize);
                const batchEmbeddings = this.embeddings.slice(i, i + batchSize);
                console.log(i)
                await lotteCollection.add({
                    documents: batchData,
                    ids: batchNames,
                    embeddings: batchEmbeddings
                })

            }
        console.log("Done")
    }

    async lotteSearch(query: string) {
        const query_embeds = await this.huggingFaceService.embedQuery(query)
        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        if(!this.lotteCollection)
         this.lotteCollection = await this.chroma.getCollection({name: "lotte"});
        return await this.lotteCollection.query({
            queryEmbeddings: query_embeds,
            nResults: 10
        })
    }


    // Query Prediction
    async antiqueQueryInit() {
        const queries = Object(await this.unPickle("Files/antique/antique_queries.pkl"));
        const queries_embeds = await this.huggingFaceService.hfEmbedDocs(queries);
        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        const ids = [...Array(queries.length).keys()].map(x => (x + 1).toString());
        const antiqueQueryCollection = await this.chroma.getOrCreateCollection({name: "antique_queries"});
        await antiqueQueryCollection.add({
            documents: queries,
            ids: ids,
            embeddings: queries_embeds
        })

        console.log(await antiqueQueryCollection.count())
        console.log("Done init antique queries")
    }

    async antiqueQueryPrediction(query: string) {
        const query_embed = await this.huggingFaceService.embedQuery(query);

        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        if(!this.antiqueQueryCollection)
        this.antiqueQueryCollection = await this.chroma.getOrCreateCollection({name: "antique_queries"});

        return this.antiqueQueryCollection.query({
            queryEmbeddings: query_embed,
            nResults: 3
        });

    }

    async lotteQueryInit() {
        const queries = Object(await this.unPickle("Files/lotte/lotte_queries.pkl"));
        const queries_embeds = await this.huggingFaceService.hfEmbedDocs(queries);
        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        const ids = [...Array(queries.length).keys()].map(x => (x + 1).toString());
        const antiqueQueryCollection = await this.chroma.getOrCreateCollection({name: "lotte_queries"});
        await antiqueQueryCollection.add({
            documents: queries,
            ids: ids,
            embeddings: queries_embeds
        })

        console.log(await antiqueQueryCollection.count())
        console.log("Done init antique queries")
    }

    async lotteQueryPrediction(query: string) {
        const query_embed = await this.huggingFaceService.embedQuery(query);

        if (!this.chroma)
            this.chroma = new ChromaClient({path: "http://localhost:8000"});
        if(!this.lotteQueryCollection)
        this.lotteQueryCollection = await this.chroma.getOrCreateCollection({name: "lotte_queries"});

        return this.lotteQueryCollection.query({
            queryEmbeddings: query_embed,
            nResults: 3
        });
    }

    async correctQuery(query: string) {
        const autocorrect = require('autocorrect')()
        const words = query.split(' ');
        let correctedWords = ""
        for (const word of words ){
            const kr = autocorrect(word)
            correctedWords+=kr + " "
        }

        return correctedWords
    }

    async unPickle(fname) {
        try {
            const data = await fs.promises.readFile(path.join(fname));
            const buffer = Buffer.from(data);
            const parser = new Parser();
            return parser.parse(buffer);
        } catch (err) {
            console.error('Error reading file:', err);
            return null;
        }
    }

}
