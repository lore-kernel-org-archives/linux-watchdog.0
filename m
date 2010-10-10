Date: Sun, 10 Oct 2010 20:23:42 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 13/14] watchdog: octeon-wdt: Use I/O clock rate for
        timing calculations.
Message-ID: <20101010182342.GC24194@infomag.iguana.be>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com> <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
Return-Path: <wim@iguana.be>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi David,

> The creation of the I/O clock domain requires some adjustments.  Since
> the watchdog counters are clocked by the I/O clock, use its rate for
> timing calculations.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org

Signed-off-by: Wim Van Sebroeck <wim@iguana.be> .

I prefer this one to go through the mips tree.

Kind regards,
Wim.
