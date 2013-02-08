Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58356 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab3BHCTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Feb 2013 21:19:36 -0500
From: "Kumar, Anil" <anilkumar.v@ti.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"wim@iguana.be" <wim@iguana.be>
Subject: RE: [PATCH] watchdog: davinci_wdt: update to devm_* API
Date: Fri, 8 Feb 2013 02:19:25 +0000
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C59AA@DBDE01.ent.ti.com>
References: <1360207935-24325-1-git-send-email-anilkumar.v@ti.com>
 <51138E41.3080708@mvista.com>
In-Reply-To: <51138E41.3080708@mvista.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Sergei

On Thu, Feb 07, 2013 at 16:51:37, Sergei Shtylyov wrote:
> Hello.
>=20
> On 07-02-2013 7:32, Kumar, Anil wrote:
>=20
> > Update the code to use devm_* API so that driver
> > core will manage resources.
>=20
> > Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> > ---
> > This patch applies on top of v3.8-rc6.
>=20
> > Tested on da850 EVM.
>=20
> > :100644 100644 e8e8724... 6ad76a3... M	drivers/watchdog/davinci_wdt.c
> >   drivers/watchdog/davinci_wdt.c |   34 +++++++++--------------------=
-----
> >   1 files changed, 9 insertions(+), 25 deletions(-)
>=20
> > diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinc=
i_wdt.c
> > index e8e8724..6ad76a3 100644
> > --- a/drivers/watchdog/davinci_wdt.c
> > +++ b/drivers/watchdog/davinci_wdt.c
> [...]
> > @@ -213,49 +212,34 @@ static int davinci_wdt_probe(struct platform_de=
vice *pdev)
> [...]
> > -	size =3D resource_size(wdt_mem);
> > -	if (!request_mem_region(wdt_mem->start, size, pdev->name)) {
> > -		dev_err(dev, "failed to get memory region\n");
> > -		return -ENOENT;
> > -	}
> > -
> > -	wdt_base =3D ioremap(wdt_mem->start, size);
> > +	wdt_base =3D devm_request_and_ioremap(&pdev->dev, wdt_mem);
> >   	if (!wdt_base) {
> > -		dev_err(dev, "failed to map memory region\n");
> > -		release_mem_region(wdt_mem->start, size);
> > -		wdt_mem =3D NULL;
> > +		dev_err(&pdev->dev, "ioremap failed\n");
> >   		return -ENOMEM;
>=20
>     Comment to devm_request_and_ioremap() suggest returning -EADDRNOTAV=
AIL=20
> instead.

Right.=20

Thanks,
Anil
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
