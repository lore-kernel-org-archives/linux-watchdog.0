Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756706Ab2ENOBC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 10:01:02 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: RE: [PATCH 1/2 V3] watchdog: Add multiple device support
Date: Mon, 14 May 2012 14:00:50 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B10236D@HASMSX103.ger.corp.intel.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
 <20120514135209.GM3074@spo001.leaseweb.com>
In-Reply-To: <20120514135209.GM3074@spo001.leaseweb.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

> changes
> >        with the comments that Hans made.
> > V3: (by Tomas)
> >     1. Fix compilation error caused by missing include to
> > watchdog_dev.h
>=20
> Is allready in linux-watchdog-next (see commit
> 1761f6851b23e1cd61705c4c053decabb14f9092)

Hmm  didn't know that -next exists till now... I'll have a look.
Thanks
Tomas=20


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
