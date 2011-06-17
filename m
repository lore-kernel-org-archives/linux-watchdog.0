Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:63458 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334Ab1FQHOu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2011 03:14:50 -0400
Date: Fri, 17 Jun 2011 09:14:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jamie Iles <jamie@jamieiles.com>
Cc: Peter Fordham <peter.fordham@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [MPCore Watchdog]: Convert from misc_dev to dynamic device
	node.
Message-ID: <20110617071439.GK23305@infomag.iguana.be>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com> <20110614234858.GA15534@gallagher> <BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com> <20110615085820.GH3075@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20110615085820.GH3075@pulham.picochip.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi All,

> On Tue, Jun 14, 2011 at 05:19:06PM -0700, Peter Fordham wrote:
> > > On Tue, Jun 14, 2011 at 04:29:26PM -0700, Peter Fordham wrote:
> > >> The current MPCore watchdog driver uses a misc_dev device node.
> > >> This patch changes it to use dynamically allocated device numbers.
> > >
> > > I'm not sure that this is the correct thing to do. =A0All other wat=
chdog devices
> > > use a miscdevice with a major:minor of 10:130, is there a specific =
reason
> > > that this node needs to be dynamic?
> >=20
> > I was under the impressions that dynamic device nodes were the way of=
 the
> > future. Is that not the case?
>=20
> Well they are for new devices/subsystems but watchdog has an establishe=
d=20
> major:minor pair that all other devices use so you don't really have to=
=20
> worry about a namespace clash.
>=20
> > I'll add the relevant checks in other places as per your suggestions.
>=20
> I've added Wim (watchdog driver maintainer), but I would think that if=20
> this change is worth doing then it should be done for all drivers.
>=20
> > > I believe the sysfs classes are pretty much
> > > deprecated now in preference of a bus too.
> >=20
> > Can you give me some more info here? I thought the sysfs stuff was th=
e
> > new right way of doing stuff. The class stuff allows udev to automati=
cally
> > create the right device node.
>=20
> So here's one that I'm aware of https://lkml.org/lkml/2011/3/25/502.  S=
o=20
> there's nothing wrong with using sysfs and a bus, but certainly a bus i=
s=20
> preferred over a class.

My opinion: we stick with the /dev/watchdog interface, we don't go for dy=
namic
device nodes but go for a sysfs interface. And this for all drivers and v=
ia the
new watchdog API. (updated version will be sent out today). Makes no sens=
e
to do this for every driver.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
