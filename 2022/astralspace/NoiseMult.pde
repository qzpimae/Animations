

class NoiseMult {

    public void initalize () {
        a=createImage(WIDTH,HEIGHT,HSB);
        A= a.pixels;
    }


    public void renderNoise7 () {

        float n1 = (float) noise.noise2(1000+(frames*renderSpeed)/3000, 2000+(frames*renderSpeed)/3000 );
        float noiseDiv1 = map(n1, -1, 1, .1, .001);

        float min = 100;
        float max = 0;


        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){

                float xScl = random(1) * (float)WIDTH/100 * (1 + globalXScale/10);// xScl = 769;
                float yScl = random(1) * (float)HEIGHT/100 * (1 + globalYScale/10);// yScl = 69;

                float tSX = 16666 + ( renderAdvanceToggle ? ((frames*renderSpeed)/3000) : -transX/22 );
                float tSY = 15555 - ( renderAdvanceToggle ? (frames*renderSpeed/10000) : transY/22 );

                float noise1 =  (float) noise.noise2(   (x/xScl)+tSX,    (y/yScl)+tSY     ) * 2;
                float noise2 =  (float) noise.noise2(   (x/xScl*2)+tSX+12, (y/yScl)/noiseDiv1+(tSY+21)  );
                float noise3 =  (float) noise.noise2(   (x/xScl*5)+tSX/2, (y/yScl*4)+(tSY/2)  );
                float noise4 =  (float) noise.noise2(   (x/xScl*2)+tSX, (y/yScl*3)+tSY  );
                
                float finalNoise = ((noise3/noise1+noise2*noise4)/2);
                
                // float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                // float sat = (float) abs(map(finalNoise, 0, 1, -100, 100));
                // float brt = (float) ((invertLight ? 50 : 0) + (float) abs(map(finalNoise, -1, 1, -100, 100))) % 100;
                
                float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                // hue = (hue + cos(frames*renderSpeed/10)*60) % 360;
                
                float mapRange = !invertLight ? 1 : 10;

                float sat = (float) abs(map(finalNoise, -1, 1, 0, 66.6));


                if (sat < min) min = sat;
                if (sat > max) max = sat;

                float brt = (float) abs(map(finalNoise, -mapRange, mapRange, -100, 100));

                if (invertLight) brt = brt > 50 ? map(brt, 50, 100, 50, 0) : map(brt, 50, 0, 50, 100); 
                
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }

        // println(min);
        // println(max);
        arrayCopy(A,pixels);
        updatePixels();

    }

    public void renderNoise6 () {


        float noiseDiv1 = noiseVar1/10;

        float min = 100;
        float max = 0;


        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){

                float xScl = (float)WIDTH/10 * (1 + globalXScale/10);// xScl = 769;
                float yScl = (float)HEIGHT/10 * (1 + globalYScale/10);// yScl = 69;

                float tSX = 16666 + ( renderAdvanceToggle ? ((frames*renderSpeed)/333) : -transX/22 );
                float tSY = 15555 - ( renderAdvanceToggle ? (frames*renderSpeed/1111) : transY/22 );

                float noise1 =  (float) noise.noise2(   (x/xScl)+tSX,    (y/yScl)+tSY     ) * 2;
                float noise2 =  (float) noise.noise2(   (x/xScl*21)+tSX+12, (y/yScl)/noiseDiv1+(tSY+21)  );
                float noise3 =  (float) noise.noise2(   (x/xScl*5)+tSX/2, (y/yScl*7)+(tSY/2)  );
                float noise4 =  (float) noise.noise2(   (x/xScl*2)+tSX, (y/yScl*3)+tSY  );
                
                float finalNoise = ((noise3/noise1+noise2/noise4)/2);
                
                // float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                // float sat = (float) abs(map(finalNoise, 0, 1, -100, 100));
                // float brt = (float) ((invertLight ? 50 : 0) + (float) abs(map(finalNoise, -1, 1, -100, 100))) % 100;
                
                float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                // hue = (hue + cos(frames*renderSpeed/10)*60) % 360;
                
                float mapRange = !invertLight ? 1 : 10;

                float sat = (float) abs(map(finalNoise, -1, 1, 0, 66.6));


                if (sat < min) min = sat;
                if (sat > max) max = sat;

                float brt = (float) abs(map(finalNoise, -mapRange, mapRange, -100, 100));

                if (invertLight) brt = brt > 50 ? map(brt, 50, 100, 50, 0) : map(brt, 50, 0, 50, 100); 
                
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }

        // println(min);
        // println(max);
        arrayCopy(A,pixels);
        updatePixels();

    }

    public void renderNoise5 () {


        float noiseDiv1 = .001;

        float min = 100;
        float max = 0;


        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){

                float xScl = (float)WIDTH/10 * (1 + globalXScale/10);// xScl = 769;
                float yScl = (float)HEIGHT/10 * (1 + globalYScale/10);// yScl = 69;

                float tSX = 16666 + ( renderAdvanceToggle ? ((frames*renderSpeed)/333) : -transX/22 );
                float tSY = 15555;// - ( renderAdvanceToggle ? (frames*renderSpeed/111) : transY/22 );

                float noise1 =  (float) noise.noise2(   (x/xScl)+tSX,    (y/yScl)+tSY     ) * 2;
                float noise2 =  (float) noise.noise2(   (x/xScl*21)+tSX+12, (y/yScl)/noiseDiv1+(tSY+21)  );
                float noise3 =  (float) noise.noise2(   (x/xScl*5)+tSX/2, (y/yScl*7)+(tSY/2)  );
                float noise4 =  (float) noise.noise2(   (x/xScl*2)+tSX, (y/yScl*3)+tSY  );
                
                float finalNoise = ((noise3/noise1+noise2/noise4)/2);
                
                // float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                // float sat = (float) abs(map(finalNoise, 0, 1, -100, 100));
                // float brt = (float) ((invertLight ? 50 : 0) + (float) abs(map(finalNoise, -1, 1, -100, 100))) % 100;
                
                float hue = (float) ((invertHue ? 180 : 0) + (float) abs(map(finalNoise, -1, 1, 339, 159))) % 360;
                float sat = (float) abs(map(finalNoise, -10, 10, 0, 100));


                // if (finalNoise < min) min = finalNoise;
                // if (finalNoise > max) max = finalNoise;

                float brt = (float) abs(map(finalNoise, -10, 10, -100, 100));
                // println(brt);
                if ( !invertLight) brt = brt %100;
                
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }

        // println(min);
        // println(max);
        arrayCopy(A,pixels);
        updatePixels();

    }

    public void renderNoise4 () {

        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){

                float xScl = WIDTH;// xScl = 769;
                float yScl = HEIGHT;// yScl = 69;

                float tSX = 16666 ;//+ ( renderAdvanceToggle ? (frames*renderSpeed/99) : -transX/22 );
                float tSY = 15555 - ( renderAdvanceToggle ? (frames*renderSpeed/111) :-transY/22 );

                float noise1 =  (float) noise.noise2(   x/xScl+tSX,    y/yScl+tSY     );
                float noise2 =  (float) noise.noise2(   x/xScl*17+tSX+12, y/yScl/2+tSY+21  );
                float noise3 =  (float) noise.noise2(   x/xScl*10+tSX/2, y/yScl*10+tSY/2  );
                float noise4 =  (float) noise.noise2(   x/xScl*2+tSX, y/yScl*3+tSY  );
                
                float finalNoise = ((noise3/noise1+noise2/noise4)/2);
                
                float hue = (float) abs(map(finalNoise, -1, 1, 339, 159)) % 360;
                float sat = (float) abs(map(finalNoise, 0, 1, -100, 100));


                float brt = (float) abs(map(finalNoise, 0, 1, -100, 100));
                
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }

        arrayCopy(A,pixels);
        updatePixels();

    }


    public void renderNoise3 () {

        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){

                float xScl = WIDTH/6.9;// globalXScale;// xScl = 769;
                float yScl = HEIGHT/3.9;// globalYScale// yScl = 69;

                float tSX = 16666 + ( renderAdvanceToggle ? (frames*renderSpeed/333) : -transX/10 );
                float tSY = 15555 - ( renderAdvanceToggle ? (frames*renderSpeed/88) :-transY/10 );
                float noise1 =  (float) noise.noise2(   x/xScl+tSX,    y/yScl+tSY     );
                float noise2 =  (float) noise.noise2(   x/xScl*15+tSX, y/yScl/2+tSY  );
                float noise3 =  (float) noise.noise2(   x/xScl*10+tSX, y/yScl*10+tSY  );
                
                float finalNoise = (noise1+noise3+noise2)/3;
                float hue = (float) abs(map(finalNoise, -1, 1, 339, 159));
                float sat = (float) abs(map(finalNoise, 0, 1, -100, 100));
                float brt = (float) abs(map(finalNoise, 0, 1, -100, 100));
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }
        arrayCopy(A,pixels);
        updatePixels();

    }

    public void renderNoise2 () {

        
        float xScl = globalXScale;// globalXScale;// xScl = 769;
        float yScl = globalYScale;// globalYScale// yScl = 69;


        loadPixels();
        for  (int x=0;x<a.width;x++){
            for (int y=0;y<a.height;y++){
                float tSX = 15666 + ( renderAdvanceToggle ? (frames*renderSpeed/99) : -transX/10 );
                float tSY = 15639 + ( renderAdvanceToggle ? (frames*renderSpeed/88) :-transY/10 );
                float noise1 =  (float) noise.noise2(x/xScl+tSX+222, y/yScl+tSY);
                float hue = (float) abs(map(noise1, -1, 1, 339, 159));
                float sat = (float) abs(map(noise1, 0, 1, -100, 100));
                float brt = (float) abs(map(noise1, 0, 1, -100, 100));
                int pos = x+a.width*y;
                A[pos] = color (hue, sat, brt);
            }
        }
        arrayCopy(A,pixels);
        updatePixels();

    }


    public void renderNoise1 () {

        float xScl = 3333;// globalXScale;// xScl = 769;
        float yScl = 222;// globalYScale// yScl = 69;


        loadPixels();
        int max = WIDTH * HEIGHT;
        for(int i = 0; i < max; i++) {
            float tSX = 15666 + ( renderAdvanceToggle ? (frames*renderSpeed/99) : -transX/10 );
            float tSY = 15639;// + ( renderAdvanceToggle ? (frames*renderSpeed/88) :-transY/10 );
            float noise1 =  (float) noise.noise2(i/xScl+tSX, i/yScl+tSY);
            float hue = (float) map(noise1, -1, 1, -360, 360) % 360;
            float sat = (float) map(noise1, 0, 1, -100, 100) % 100;
            float brt = (float) map(noise1, 0, 1, -100, 100) % 100;
        

            pixels[i] = color (hue, sat, brt);
            

        }
        updatePixels();

    }

    
}