Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756541AbcILWc7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Sep 2016 18:32:59 -0400
Date: Mon, 12 Sep 2016 15:32:57 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: TXx9: Convert to Common Clock Framework
Message-ID: <20160912223257.GJ7243@codeaurora.org>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
 <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473584398-12942-3-git-send-email-geert@linux-m68k.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/11, Geert Uytterhoeven wrote:
> Replace the custom minimal clock implementation for Toshiba TXx9 by a
> basic implementation using the Common Clock Framework.
> 
> The only clocks that are provided are those needed by TXx9-specific
> drivers ("imbus" and "spi" (TX4938 only)), and their common parent
> clock "gbus". Other clocks can be added when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
