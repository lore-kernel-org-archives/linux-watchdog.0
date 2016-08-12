Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35831 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbcHLTBZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Aug 2016 15:01:25 -0400
Date: Fri, 12 Aug 2016 14:01:23 -0500
From: Rob Herring <robh@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	soren.brinkmann@xilinx.com, shubhrajyoti.datta@gmail.com,
	michal.simek@xilinx.com, wim@iguana.be
Subject: Re: [PATCHv5] watchdog: xilinx: Add clock support
Message-ID: <20160812190123.GB16954@rob-hp-laptop>
References: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 12, 2016 at 12:17:01PM +0530, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> fix spaces and error path.
> v3
> do not fail existing dts
> v4:
> fix the error prints as the clock is optional
> v5:
> remove some more prints
> 
>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/watchdog/of_xilinx_wdt.c                   | 25 ++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
