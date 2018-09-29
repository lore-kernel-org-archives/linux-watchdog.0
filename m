Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39359 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3A6k (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Sep 2018 20:58:40 -0400
Date: Sat, 29 Sep 2018 11:29:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: dt-bindings: watchdog: renesas-wdt: Document r8a7744 support
Message-ID: <20180929182911.GA20830@roeck-us.net>
References: <1537895241-7686-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537895241-7686-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 25, 2018 at 06:07:21PM +0100, Biju Das wrote:
> RZ/G1N (R8A7744) watchdog implementation is compatible with R-Car
> Gen2, therefore add relevant documentation.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 9407212..d72d118 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -6,6 +6,7 @@ Required properties:
>  		version.
>  	       Examples with soctypes are:
>  		 - "renesas,r8a7743-wdt" (RZ/G1M)
> +		 - "renesas,r8a7744-wdt" (RZ/G1N)
>  		 - "renesas,r8a7745-wdt" (RZ/G1E)
>  		 - "renesas,r8a774a1-wdt" (RZ/G2M)
>  	         - "renesas,r8a7790-wdt" (R-Car H2)
