Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35066 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759403AbcAKVcL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 Jan 2016 16:32:11 -0500
Date: Mon, 11 Jan 2016 13:32:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] watchdog: Drop pointer to watchdog device from
 struct watchdog_device
Message-ID: <20160111213210.GA12423@roeck-us.net>
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
 <20160111212918.GD6613@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160111212918.GD6613@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 11, 2016 at 10:29:18PM +0100, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
> > The lifetime of the watchdog device pointer is different from the lifetime
> > of its character device. Remove it entirely to avoid race conditions, and
> > to make sure that drivers don't start to use it again.
> 
> This patchset has been added to linux-watchdog-next.
> 
Thanks!

Guenter
