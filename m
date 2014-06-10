Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39849 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaFJTXk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 10 Jun 2014 15:23:40 -0400
Date: Tue, 10 Jun 2014 12:23:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: George Cherian <george.cherian@ti.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: dw_wdt: Remove the un-necessary check
 after platform_get_resource()
Message-ID: <20140610192331.GA7773@roeck-us.net>
References: <1402375208-18445-1-git-send-email-george.cherian@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1402375208-18445-1-git-send-email-george.cherian@ti.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 10, 2014 at 10:10:06AM +0530, George Cherian wrote:
> devm_ioremap_resource() checks for valid resource.
> Remove the un-necessary check after platform_get_resource().
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
