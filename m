Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35222 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeLTUfZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Dec 2018 15:35:25 -0500
Date: Thu, 20 Dec 2018 14:35:22 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a774c0
 support
Message-ID: <20181220203522.GA17057@bogus>
References: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732333-6086-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 13 Dec 2018 20:18:53 +0000, Fabrizio Castro wrote:
> RZ/G2E (R8A774C0) watchdog implementation is compatible with R-Car
> Gen3, therefore add relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
