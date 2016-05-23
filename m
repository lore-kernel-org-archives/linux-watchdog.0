Return-path: <brian.boylston@hpe.com>
From: "Boylston, Brian" <brian.boylston@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH] watchdog: hpwdt: update HPE maintainer
Date: Mon, 23 May 2016 19:38:46 +0000
Message-ID: <CS1PR84MB011968DAA650E6408707CC1A8E4E0@CS1PR84MB0119.NAMPRD84.PROD.OUTLOOK.COM>
References: <20160523133329.10075-1-brian.boylston@hpe.com>
 <57431A13.1040406@roeck-us.net>
In-Reply-To: <57431A13.1040406@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Guenter Roeck wrote on 2016-05-23:
> Hi Brian,
>=20
> On 05/23/2016 06:33 AM, Brian Boylston wrote:
>> Update the HPE maintainer of the hpwdt driver.
>>=20
>> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
>=20
> A driver's maintainer is commonly updated in MAINTAINERS, not in the driv=
er itself.
> If you are the formal maintainer, I would suggest to add an entry for the=
 driver
> into the MAINTAINERS file; this would ensure that you get copied on patch=
es
> affecting the driver.

Thanks, Guenter.  I'll work on an update to MAINTAINERS.
Okay if I leave my name out of hpwdt.txt then?

Brian

>=20
> Thanks,
> Guenter
>=20
>> ---
>> This patch applies on top of:
>> [PATCH V4] watchdog: hpwdt: Adjust documentation to match latest kernel =
module parameters.
>> which I think is already in linux-watchdog-next.
>>=20
>>   Documentation/watchdog/hpwdt.txt | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>> diff --git a/Documentation/watchdog/hpwdt.txt b/Documentation/watchdog/h=
pwdt.txt
>> index a40398c..27106ff 100644
>> --- a/Documentation/watchdog/hpwdt.txt
>> +++ b/Documentation/watchdog/hpwdt.txt
>> @@ -1,9 +1,12 @@
>> -Last reviewed: 04/04/2016
>> +Last reviewed: 05/20/2016
>>=20
>>                        HPE iLO NMI Watchdog Driver NMI sourcing for iLO
>>                        based ProLiant Servers Documentation and Driver
>>                        by
>> -              Thomas Mingarelli <thomas.mingarelli@hpe.com>
>> +                         Thomas Mingarelli
>> +
>> +                       Currently maintained by
>> +               Brian Boylston <brian.boylston@hpe.com>
>>=20
>>    The HPE iLO NMI Watchdog driver is a kernel module that provides basi=
c
>>    watchdog functionality and the added benefit of NMI sourcing. Both th=
e
>> @@ -95,4 +98,3 @@ Last reviewed: 04/04/2016
>>=20
>>=20
>>    -- Tom Mingarelli
>> -    (thomas.mingarelli@hpe.com)
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
