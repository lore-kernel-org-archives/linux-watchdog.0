Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:5215 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753869Ab1HDSHm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Aug 2011 14:07:42 -0400
Date: Thu, 4 Aug 2011 20:07:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: WatchDog Timer Driver Core - use passed
	watchdog_device
Message-ID: <20110804180739.GT4227@infomag.iguana.be>
References: <201108031538.21137.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201108031538.21137.hartleys@visionengravers.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi H Hartley,

> Use the passed watchdog_device instead of the static global variable when
> testing and setting the status in watchdog_ping, watchdog_start, and
> watchdog_stop.  Note that the callers of these functions are actually
> passing the static global variable.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

This will be added. We will need this when we go to the sysfs part of the core anyway.

Kind regards,
Wim.

