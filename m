Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42786 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3JAPoO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Oct 2013 11:44:14 -0400
Date: Tue, 1 Oct 2013 08:44:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [2/2] watchdog: ts72xx_wdt: locking bug in ioctl
Message-ID: <20131001154402.GA309@roeck-us.net>
References: <20130823084059.GE31293@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130823084059.GE31293@elgon.mountain>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 23, 2013 at 04:40:59PM -0000, Dan Carpenter wrote:
> Calling the WDIOC_GETSTATUS & WDIOC_GETBOOTSTATUS and twice will cause a
> interruptible deadlock.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
