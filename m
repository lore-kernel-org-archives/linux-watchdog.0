Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mtaext1.cujae.edu.cu ([200.55.139.24]:57274 "EHLO
	mtaext1.cujae.edu.cu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760953Ab2FVB5O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jun 2012 21:57:14 -0400
Message-ID: <4FE37029.50007@udio.cujae.edu.cu>
Date: Thu, 21 Jun 2012 14:04:09 -0500
From: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
To: Michal Simek <monstr@monstr.eu>
CC: linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: xilinx: Read clock frequency directly from
	DT node
References: <1340261140-10166-1-git-send-email-monstr@monstr.eu>
In-Reply-To: <1340261140-10166-1-git-send-email-monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> Do not use clock-frequency property from parent node.
> Use it from watchdog node.
>
> Signed-off-by: Michal Simek<monstr@monstr.eu>

Acked-By: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>

> ---
>   drivers/watchdog/of_xilinx_wdt.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 55d2f66..294fb4e 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -297,7 +297,7 @@ static int __devinit xwdt_probe(struct platform_device *pdev)
>
>   	no_timeout = 0;
>
> -	pfreq = (u32 *)of_get_property(pdev->dev.of_node->parent,
> +	pfreq = (u32 *)of_get_property(pdev->dev.of_node,
>   					"clock-frequency", NULL);
>
>   	if (pfreq == NULL) {

Participe en la XVI Convencion Cientifica de Ingenieria y Arquitectura del 26 al 30 de noviembre de 2012. La Habana, Cuba: http://ccia.cujae.edu.cu

Consulte la enciclopedia colaborativa cubana. http://www.ecured.cu
