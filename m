Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:45199 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761110Ab2EQHTJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 03:19:09 -0400
Date: Thu, 17 May 2012 09:19:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
Message-ID: <20120517071906.GU3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com> <20120514135209.GM3074@spo001.leaseweb.com> <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com> <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i0qc6d_X6f2iPq9_CFPYs0Gt3rYwmC4-x2zS8ykeddXBavHQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

> I see you've add my changes into the patch and  rebased that tree,
> usually  this is not preferable strategy for public git tree as it
> creates conflicts.
> Should we expect the -next tree to be rebased from time to time?

I try to avoid rebasing, but it's sometimes better to change new patches
(although sometimes it's better not to). So Yes a rebase is possible in
linux-watchdog-next. (Which is according to the rules of linux-next).

Kind regards,
Wim.

