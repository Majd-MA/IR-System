import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import {HuggingFaceService} from "./HF/hf.service";
import { HfModule } from './hf/hf.module';
import { ChromaService } from './chroma/chroma.service';

@Module({
  imports: [HfModule],
  controllers: [AppController],
  providers: [AppService,HuggingFaceService, ChromaService],
})
export class AppModule {}
