Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55891 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbcHSTRw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 19 Aug 2016 15:17:52 -0400
Date: Fri, 19 Aug 2016 12:17:50 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: TXx9: Convert to Common Clock Framework
Message-ID: <20160819191750.GV361@codeaurora.org>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471541667-30689-4-git-send-email-geert@linux-m68k.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/18, Geert Uytterhoeven wrote:
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index ada92db92f87d91a..2fdbcf91b2cc472c 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -560,8 +527,39 @@ void __init plat_time_init(void)
>  	txx9_board_vec->time_init();
>  }
>  
> +static void txx9_clk_init(void)
> +{
> +	struct clk *clk;
> +	int error;
> +
> +	clk = clk_register_fixed_rate(NULL, "gbus", NULL, 0, txx9_gbus_clock);

Can we use the clk_hw_*() based variants instead please?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
