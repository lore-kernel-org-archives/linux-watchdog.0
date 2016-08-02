Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:59903
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754709AbcHBOPh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Aug 2016 10:15:37 -0400
Date: Tue, 2 Aug 2016 07:00:17 -0700
From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<michal.simek@xilinx.com>, <wim@iguana.be>
Subject: Re: [PATCH] watchdog: xilinx: Add clock support
Message-ID: <20160802140017.GN3847@xsjsorenbubuntu>
References: <1470134220-12927-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470134220-12927-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2016-08-02 at 16:07:00 +0530, Shubhrajyoti Datta wrote:
> Add support for the clock. Currently we enable
> at probe and relinquish at remove.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>

	Sören
