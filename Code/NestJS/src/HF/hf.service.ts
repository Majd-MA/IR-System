import { Injectable} from '@nestjs/common';
import {HuggingFaceInferenceEmbeddings} from "@langchain/community/embeddings/hf"
import {Embeddings} from "chromadb";

@Injectable()
export class HuggingFaceService {

    constructor() {}
    huggingFace = null

    async embedQuery(query:string){
        console.time('Hugging Face embedding');
        if(!this.huggingFace)
            this.huggingFace =new HuggingFaceInferenceEmbeddings({
            model:"sentence-transformers/multi-qa-MiniLM-L6-cos-v1",
            apiKey:"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"
        })
        console.timeEnd('Hugging Face embedding');
        return await this.huggingFace.embedQuery(query);
    }

    async hfEmbedDocs(docs:string[]){
        if(!this.huggingFace)
            this.huggingFace =new HuggingFaceInferenceEmbeddings({
                model:"sentence-transformers/multi-qa-MiniLM-L6-cos-v1",
                apiKey:"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"
            })
        return await this.huggingFace.embedDocuments(docs);
    }
}