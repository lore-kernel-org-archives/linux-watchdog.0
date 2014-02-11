Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36124 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbaBKKCk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 05:02:40 -0500
Date: Tue, 11 Feb 2014 12:09:36 +0200
From: 'Mika Westerberg' <mika.westerberg@linux.intel.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
Message-ID: <20140211100936.GC18029@intel.com>
References: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Feb 11, 2014 at 03:59:38PM +0900, Jingoo Han wrote:
> Make 'ts72xx_wdt_pdev' static, because it is used only in this
> file. It also fixes the following sparse warning.
> 
>   warning: symbol 'ts72xx_wdt_pdev' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
