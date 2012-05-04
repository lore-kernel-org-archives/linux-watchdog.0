Date: Fri, 4 May 2012 15:22:11 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 11/14] watchdog: MIPS: lantiq: implement OF support and minor fixes
Message-ID: <20120504132211.GV3074@spo001.leaseweb.com>
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-11-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1336133919-26525-11-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

> Add support for OF. We also apply the following small fixes
> * reduce boiler plate by using devm_request_and_ioremap
> * sane error path for the clock
> * move LTQ_RST_CAUSE_WDTRST to a soc specific header file
> * add a message to show that the driver loaded
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> 
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
