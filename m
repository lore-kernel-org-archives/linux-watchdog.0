Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:38247 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760170Ab2EKQCX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 12:02:23 -0400
Date: Fri, 11 May 2012 18:02:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/4] watchdog: Add multiple device support
Message-ID: <20120511160218.GE3074@spo001.leaseweb.com>
References: <20120321152418.20045.35525.stgit@bob.linux.org.uk> <20120504123815.GS3074@spo001.leaseweb.com> <20120510192023.GA31117@spo001.leaseweb.com> <4FACC4C1.9040104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FACC4C1.9040104@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hans,

> >+		if (id != 0)
> >+			return ret;
> 
> 
> I believe the check above should be:
> 		if (id != 0 || ret != -EBUSY)
> 			return ret;
> 
> IOW we should not retry the registration if it failed for another reason
> then the id already being taken by a legacy driver.

Than for readibility we should say:
		if (!(id == 0 && ret == -EBUSY))
			return ret

Kind regards,
Wim.

