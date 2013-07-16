Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13762 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932647Ab3GPNYt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 09:24:49 -0400
Date: Tue, 16 Jul 2013 09:24:30 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be
Subject: Re: [PATCH 06/10] watchdog: orion: Update device-tree binding
 documentation
Message-ID: <20130716132430.GD12062@titan.lakedaemon.net>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373931163-12670-7-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1373931163-12670-7-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 15, 2013 at 08:32:39PM -0300, Ezequiel Garcia wrote:
> Now that the 'reg' property meaning has been changed,
> this commit updates the deivce-tree binding documentation.

nit. s/deivce/device/

> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/watchdog/orion-wdt.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> index 5dc8d30..48a71fc 100644
> --- a/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/orion-wdt.txt
> @@ -3,7 +3,8 @@
>  Required Properties:
>  
>  - Compatibility : "marvell,orion-wdt"
> -- reg		: Address of the timer registers
> +- reg		: First cell contains the register for the watchdog counter.
> +		  Second cell contains the register for the RSTOUT mask.
>  
>  Optional properties:
>  
> @@ -11,9 +12,10 @@ Optional properties:
>  
>  Example:
>  
> -	wdt@20300 {
> +	wdt@20324 {
>  		compatible = "marvell,orion-wdt";
> -		reg = <0x20300 0x28>;
> +		reg = <0x20324 0x4
> +		       0x20108 0x4>;
>  		timeout-sec = <10>;
>  		status = "okay";
>  	};
> -- 
> 1.8.1.5
> 
