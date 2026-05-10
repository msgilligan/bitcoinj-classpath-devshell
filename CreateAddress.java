///usr/bin/env java "$0" "$@" ; exit $?

import org.bitcoinj.crypto.ECKey;
import static org.bitcoinj.base.BitcoinNetwork.*;
import static org.bitcoinj.base.ScriptType.*;

void main() {
   IO.println("Address generated: " + new ECKey().toAddress(P2WPKH, MAINNET));
}
