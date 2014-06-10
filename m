Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59578 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaFJTYy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jun 2014 15:24:54 -0400
Date: Tue, 10 Jun 2014 12:24:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: George Cherian <george.cherian@ti.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] watchdog: shwdt: Remove the unnecessary check of
 resource after platform_get_resource()
Message-ID: <20140610192446.GC7773@roeck-us.net>
References: <1402375208-18445-1-git-send-email-george.cherian@ti.com>
 <1402375208-18445-3-git-send-email-george.cherian@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402375208-18445-3-git-send-email-george.cherian@ti.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 10, 2014 at 10:10:08AM +0530, George Cherian wrote:
> devm_ioremap_resource check for a valid resource. Remove the unnecessary check.
> Also group platform_get_resource and devm_ioremap_resource together for better
> readability.
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
