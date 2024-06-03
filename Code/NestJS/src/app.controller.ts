import {Body, Controller, Get, Param, Post, Query} from '@nestjs/common';
import { AppService } from './app.service';
import {HuggingFaceService} from "./HF/hf.service";
import {ChromaService} from "./chroma/chroma.service";

@Controller()
export class AppController {
  constructor(
      private readonly huggingFaceService: HuggingFaceService,
      private readonly chromaService :ChromaService,
      private readonly appService :AppService,
  ) {}

  // Antique
  @Post('antique/search')
  antiqueSearch(
      @Body('query') query: string,
  ) {
    return this.chromaService.antiqueSearch(query);
  }

  @Get('antique/docs')
  async initDoc(){
    await this.chromaService.antiqueInitDocs()
  }
  @Get('antique/ids')
  async initIds(){
    await this.chromaService.antiqueInitIds()
  }
  @Get('antique/embeds')
  async initEmbed(){
    await this.chromaService.antiqueInitEmbeddings()
  }

  @Get('antique/init')
  async antiqueInit(){
    await this.chromaService.antiqueInit()
  }

  @Get('antique/query/init')
  async initAntiqueQueries(){
    await this.chromaService.antiqueQueryInit();
  }

  @Post('antique/query/predict')
  async antiqueQueryPredict(
      @Body('query') query: string,
  ){
    return await this.chromaService.antiqueQueryPrediction(query);
  }


  // Lotte Science
  @Post('lotte/search')
  lotteSearch(
      @Body('query') query: string,
  ) {
    return this.chromaService.lotteSearch(query);
  }

  @Get('lotte/docs')
  async initDocLotte(){
    await this.chromaService.lotteInitDocs()
  }
  @Get('lotte/ids')
  async initIdsLotte(){
    await this.chromaService.lotteInitIds()
  }
  @Get('lotte/embeds')
  async initEmbedLotte(){
    await this.chromaService.lotteInitEmbeddings()
  }

  @Get('lotte/init')
  async antiqueInitLotte(){
    await this.chromaService.lotteInit()
  }

  @Get('lotte/query/init')
  async initLotteQueries(){
    await this.chromaService.lotteQueryInit();
  }

  @Post('lotte/query/predict')
  async lotteQueryPredict(
      @Body('query') query: string,
  ){
    return await this.chromaService.lotteQueryPrediction(query);
  }

  @Get('query/correction')
  async correct(
      @Query('query') query: string
  ){
    return await this.chromaService.correctQuery(query);
  }

  @Get()
  async getHello()
  {
    return this.huggingFaceService.embedQuery("hello")
  }
}
