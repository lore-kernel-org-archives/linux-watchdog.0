Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:44845 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab3HBD4y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Aug 2013 23:56:54 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so197367pbb.14
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Aug 2013 20:56:54 -0700 (PDT)
Date: Thu, 1 Aug 2013 20:56:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wim Van Sebroeck' <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>
Subject: Re: [PATCH 2/2] watchdong: kempld_wdt: fix bit mask definition
Message-ID: <20130802035653.GC26898@roeck-us.net>
References: <003801ce8e79$aea68a20$0bf39e60$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801ce8e79$aea68a20$0bf39e60$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 01, 2013 at 02:40:51PM +0900, Jingoo Han wrote:
> STAGE_CFG bits are defined as [5:4] bits. However, '(((x) & 0x30) << 4)'
> handles [9:8] bits. Thus, it should be fixed in order to handle
> [5:4] bits.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Good catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
