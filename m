Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([85.17.2.162]:40167 "EHLO
        spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754082AbcJHOAC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Oct 2016 10:00:02 -0400
Date: Sat, 8 Oct 2016 15:59:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com, shubhrajyoti.datta@gmail.com,
        michal.simek@xilinx.com
Subject: Re: [PATCHv5] watchdog: xilinx: Add clock support
Message-ID: <20161008135954.GA23290@spo001.leaseweb.nl>
References: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470984421-3494-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

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

This patch was added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.

