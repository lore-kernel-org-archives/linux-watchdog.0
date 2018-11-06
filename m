Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37424 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbeKGBYQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Nov 2018 20:24:16 -0500
Date: Tue, 6 Nov 2018 09:58:22 -0600
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a77470
 support
Message-ID: <20181106155822.GA2181@bogus>
References: <1540544153-48098-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540544153-48098-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 26 Oct 2018 09:55:53 +0100, Biju Das wrote:
> RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car
> Gen2, therefore add relevant documentation.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch is tested against linux-next
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
