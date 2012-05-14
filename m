Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50259 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756421Ab2ENOI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 10:08:58 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@linux.intel.com>
Subject: RE: [PATCH 1/2 V3] watchdog: Add multiple device support
Date: Mon, 14 May 2012 14:07:31 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B102384@HASMSX103.ger.corp.intel.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
 <20120514140138.GN3074@spo001.leaseweb.com>
In-Reply-To: <20120514140138.GN3074@spo001.leaseweb.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable



> Hi Tomas,
>=20
> >  	ret =3D watchdog_dev_register(wdd);
> >  	if (ret) {
> > -		pr_err("error registering /dev/watchdog (err=3D%d)\n", ret);
> > -		return ret;
> > +		ida_simple_remove(&watchdog_ida, id);
> > +		if (!(id =3D=3D 0 || ret =3D=3D -EBUSY))
> > +			return ret;
> > +
> > +		/* Retry in case a legacy watchdog module exists */
>=20
> Nope, this should stay
> if (!(id =3D=3D 0 && ret =3D=3D -EBUSY))
>=20
> because we will only retry, if we have the possibility that another leg=
acy
> watchdog is allready there:
> i.e. when the id =3D=3D 0 and when we have a -EBUSY as a return code.A

You are right... I've wrote the statement (id =3D=3D 0 || ret =3D=3D -EBU=
SY)  and then saw the that readability=20
comment  and forgot to change the II into && as well.
Thanks
Tomas


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
