Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mfdf0201.ocn.ad.jp ([153.128.50.79]:35802 "EHLO
        mfdf0201.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbcIMPA4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Sep 2016 11:00:56 -0400
Date: Wed, 14 Sep 2016 00:00:43 +0900 (JST)
Message-Id: <20160914.000043.2112235063844984466.anemo@mba.ocn.ne.jp>
To: geert@linux-m68k.org
Cc: ralf@linux-mips.org, wim@iguana.be, linux@roeck-us.net,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: TXx9: Convert to Common Clock Framework
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
        <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, 11 Sep 2016 10:59:58 +0200, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Replace the custom minimal clock implementation for Toshiba TXx9 by a
> basic implementation using the Common Clock Framework.
> 
> The only clocks that are provided are those needed by TXx9-specific
> drivers ("imbus" and "spi" (TX4938 only)), and their common parent
> clock "gbus". Other clocks can be added when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on RBTX4927.
> 
> v2:
>   - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
>   - Use new clk_hw-centric clock registration API.

Thank you for updated patch.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
