import { Module } from '@nestjs/common';
import {HuggingFaceService} from "./hf.service";

@Module({
    providers:[HuggingFaceService],
    exports: [HuggingFaceService],
})
export class HfModule {}
