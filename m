Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36816 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812AbcHDR31 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Aug 2016 13:29:27 -0400
Date: Thu, 4 Aug 2016 12:29:19 -0500
From: Rob Herring <robh@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	soren.brinkmann@xilinx.com, shubhrajyoti.datta@gmail.com,
	michal.simek@xilinx.com, wim@iguana.be
Subject: Re: [PATCHv2] watchdog: xilinx: Add clock support
Message-ID: <20160804172918.GA22921@rob-hp-laptop>
References: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 03, 2016 at 09:58:38AM +0530, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
> 
> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> fix spaces and error path.
> 
>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>  drivers/watchdog/of_xilinx_wdt.c                   | 23 ++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> index 6d63782..b0a9fa3 100644
> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
> @@ -5,6 +5,8 @@ Required properties:
>  - compatible		: Should be "xlnx,xps-timebase-wdt-1.00.a" or
>  			  "xlnx,xps-timebase-wdt-1.01.a".
>  - reg			: Physical base address and size
> +- clocks		: Input clock specifier. Refer to common clock
> +			  bindings.

You can't add new required properties. Doing so breaks compatibility 
with old DTs.

Rob
