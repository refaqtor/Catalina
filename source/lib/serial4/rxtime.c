#include <serial4.h>
#include <cog.h>

int s4_rxtime(unsigned port, unsigned ms) {
   unsigned t = _cnt();
   int rxbyte;

   while (1) {
      rxbyte = s4_rxcheck(port);
      if ((rxbyte >= 0) || (((_cnt() - t) / (_clockfreq() / 1000)) > ms)) {
         break;
      }
   }
   return rxbyte;
}
