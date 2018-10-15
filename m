Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44835 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAlc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 Oct 2018 20:41:32 -0400
Date: Mon, 15 Oct 2018 11:55:27 -0500
From: Rob Herring <robh@kernel.org>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a7744
 support
Message-ID: <20181015165527.GA14954@bogus>
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
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
