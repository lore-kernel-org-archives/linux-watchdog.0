Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:57704 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755878Ab2EDNEB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 May 2012 09:04:01 -0400
Date: Fri, 4 May 2012 14:38:15 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-watchdog@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
Message-ID: <20120504123815.GS3074@spo001.leaseweb.com>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120321152418.20045.35525.stgit@bob.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alan,

> We keep the old /dev/watchdog interface file for the first watchdog via
> miscdev. This is basically a cut and paste of the relevant interface code
> from the rtc driver layer tweaked for watchdog.
> 
> Revised to fix problems noted by Hans de Goede
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I'm ok with the principle. Need some more thoughts about the code (meaning: that the ID assignment should imho be in the watchdog_core.c file).

I do have one question though: why did you use your own assign_id routines and not ida_simple_get/ida_simple_remove for instance?

Thanks,
Wim.

