Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:17980 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab2CVIOA convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-watchdog@vger.kernel.org:4:1>);
	Thu, 22 Mar 2012 04:14:00 -0400
Message-Id: <4F6AED56020000780007A161@nat28.tlf.novell.com>
Date: Thu, 22 Mar 2012 08:13:58 +0000
From: "Jan Beulich" <JBeulich@suse.com>
To: "Wim Van Sebroeck" <wim@iguana.be>
Cc: "xen-devel" <xen-devel@lists.xen.org>,
	"Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog/xen: don't clear is_active when
 xen_wdt_stop() failed
References: <4F670B3C020000780007935F@nat28.tlf.novell.com>
 <20120321195049.GQ10698@spo001.leaseweb.com>
In-Reply-To: <20120321195049.GQ10698@spo001.leaseweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

>>> On 21.03.12 at 20:50, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Jan,
>=20
>> xen_wdt_release() shouldn't clear is_active even when the watchdog
>> didn't get stopped (which by itself shouldn't happen, but let's return
>> a proper error in this case rather than adding a BUG() upon hypercall
>> failure).
>>=20
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>=20
>> ---
>>  drivers/watchdog/xen_wdt.c |    8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>=20
>> --- 3.3/drivers/watchdog/xen_wdt.c
>> +++ 3.3-xen-watchdog-release/drivers/watchdog/xen_wdt.c
>> @@ -131,16 +131,18 @@ static int xen_wdt_open(struct inode *in
>> =20
>>  static int xen_wdt_release(struct inode *inode, struct file *file)
>>  {
>> +	int err =3D 0;
>> +
>>  	if (expect_release)
>> -		xen_wdt_stop();
>> +		err =3D xen_wdt_stop();
>>  	else {
>>  		printk(KERN_CRIT PFX
>>  		       "unexpected close, not stopping watchdog!\n");
>>  		xen_wdt_kick();
>>  	}
>> -	is_active =3D false;
>> +	is_active =3D err;
>>  	expect_release =3D false;
>> -	return 0;
>> +	return err;
>>  }
>> =20
>>  static ssize_t xen_wdt_write(struct file *file, const char __user *da=
ta,
>=20
> Just for my understanding:
> is_active is a bool value and err is an integer. What values are return=
ed by=20
> xen_wdt_stop?

xen_wdt_stop() returns the usual -errno values. Assignments from
non-bool to bool convert the value (non-zero -> true, zero -> false),
i.e. is_active gets set to false only if xen_wdt_stop() succeeded.

Jan

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
