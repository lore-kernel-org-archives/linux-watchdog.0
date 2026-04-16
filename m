Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4639B974;
	Thu, 16 Apr 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356486; cv=none; b=ZJWiI8O7I79844kSd6LUfI5jUqESmX4nhRQeDNC4Bu3Ga3UQroM1W3Td5TS1TZmrEVkMAIQkxeoiQwBao8WSQieR6GxxiVvrIItCbnDqvHjZ1ohZb7MY9MLmppSWksPsFYNRO0j9c7Rd7SPHK1dRmdPnfOWlhHwfbGBXc8m5rQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356486; c=relaxed/simple;
	bh=F41xphddF3G8VLzEbapMr7zx46PnGnAwuJXe5tuOA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtDVpf/qiyrjAKpgaSGlo8aWRI8JP8AQ0yIBvaLsXfb4qTmrjYHaj+k+qnW+92zFaoIxJTSsnuF4MSXRwGJjGzUswnWpoJNhQh79jV/558sp/0ZYmFTBbfDR0crQQLfnOlbiDWzUJn0kaW4KYodXrmP1O5b3i8anj9941Y6ZPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=buFNr57o; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="buFNr57o"
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GC46oG721134;
	Thu, 16 Apr 2026 16:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=MMmMA8vXtXXVaXJLzQEV48jEEQ
	iW08/Pw4156fMBg3I=; b=buFNr57oV4P6lF/lAkJ8WHbcxRha2dRjYuUYRGzFoj
	/GZ7ceyMkcsS3gJRGgwLMpQVBZ5qzgwiv8cGWQfzbzsDX+DTXwwVD9iAyOykuJNY
	Fa06LD8hGIH4b4Oyyhvl8aeikLliu3etZfzQvrxGKp8UYJ7p3SlDUtf4ZvJoTzyP
	xzX0/F6mRqom0J6vnWUO0cRzhL0LIM21vSotJRJ5z4w3/XxbmDwyNHV9kh2B+pwT
	C8aDKo9zbEfQoOC9TwXBNgMeQQNr87uF3nD51X0VO53I6+9N4Q3mfBHhsMikToHd
	w/WOSJ+LQTrs2UCMeDjSTUZtfBW/jiiO2PrV0Neid87A==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4djyevukck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 16:21:07 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1883A88F;
	Thu, 16 Apr 2026 16:20:58 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id B019C808513;
	Thu, 16 Apr 2026 16:20:57 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:20:55 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter <craig.lamparter@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
        Steve Collins <s.collins@hpe.com>
Subject: Re: [PATCH v2] watchdog/hpwdt: Refine hpwdt message for UV platform
Message-ID: <aeEMZyN94Hj6JWHo@swahl-home.5wahls.com>
References: <20260318155005.90271-1-steve.wahl@hpe.com>
 <f7cc1132-390f-4f2a-8884-5e3d90b8be8c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7cc1132-390f-4f2a-8884-5e3d90b8be8c@roeck-us.net>
X-Authority-Analysis: v=2.4 cv=PIo/P/qC c=1 sm=1 tr=0 ts=69e10c73 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=ZSrvDirOKP4VPF05hnFf:22 a=VwQbUJbxAAAA:8
 a=MvuuwTCpAAAA:8 a=_jlGtV7tAAAA:8 a=aBXCVS296YcZIqr2DCYA:9 a=CjuIK1q_8ugA:10
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE1NiBTYWx0ZWRfX9AZS1ge8NqjG
 +hmwTmvSSCXlMOVwrToGcbfqv5wwn1/iILUz2YP/5YsLmeeRU5epQWpHc7ZssuTPHnjFo+2yo/R
 AzPaOmU12QM/7/rTGRCL9yKYSnqriCyBrb31NgdWrs+/YlrIYen0wJhEBSvh/2ZV1uqkLsCN7J1
 GNhMejdbDx15nTNXWc+UX/i4HKcicDA4WpFiBIit7MgESjahHlybAGZr9KE75hTIcuf503Y67Xs
 0pwD4vwzakPCiEApjl7SG8OJMsA9/6KD8hhaArwG3dodT2l3o8E9SVsStsG541bPwlN2VLO1KQp
 dxk2LL8pZRrH4tS4VvJwWvAAY07cRXLb0RGkozyTE2NTJcbXt/I5TQYwj3ndO9dUpvv7AlHQuD4
 VqtujxADTdWSTr8rm0idZaSucrrshe+j+v6BzuUUDYAttqN3LYdEO+KrBigZsT6q3aRuQPnNXMx
 A3Z3hKzEF+PDHYI1uzQ==
X-Proofpoint-ORIG-GUID: AHTVhZQjp4m3Qa5ZSpg6GEooMKUVitrQ
X-Proofpoint-GUID: AHTVhZQjp4m3Qa5ZSpg6GEooMKUVitrQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160156

On Wed, Mar 18, 2026 at 10:42:09AM -0700, Guenter Roeck wrote:
> On 3/18/26 08:50, Steve Wahl wrote:
> > The watchdog hardware the hpwdt driver uses was added to the UV
> > platform for UV_5, but the logging mentioned by this driver was not
> > added to the BIOS.  When the watchdog fires, the printed message had
> > the administrators and developers looking for non-existent log files,
> > and confused about whether a watchdog actually tripped.
> > 
> > Change the message that prints on UV platforms so it doesn't send the
> > user looking for non-existent logs.
> > 
> > To aid in any future debugging, include all 8 bits of the NMISTAT
> > register in the output, not just the two bits being used to determine
> > this was "mynmi".  And provide names to the bits in NMISTAT so the
> > code is easier to understand.
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Question: With Guenter's review, will this automatically follow some
path into the kernel tree, or do I need to call more attention to it?

Thanks,

--> Steve Wahl, HPE

> > ---
> > 
> > v1 disucsion:
> > https://lore.kernel.org/all/20260316214530.104344-1-steve.wahl@hpe.com
> > 
> > v2: Fix subject line; remove hpwdt_my_nmi function, and inline what it
> > formerly did, reducing complexity. This addresses comments from
> > Guenter Roeck.
> > 
> >   drivers/watchdog/hpwdt.c | 22 +++++++++++++++-------
> >   1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index ae30e394d176..ba08189937ec 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -22,6 +22,7 @@
> >   #include <linux/watchdog.h>
> >   #ifdef CONFIG_HPWDT_NMI_DECODING
> >   #include <asm/nmi.h>
> > +#include <asm/uv/uv.h>
> >   #endif
> >   #include <linux/crash_dump.h>
> > @@ -158,24 +159,31 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
> >   	return 0;
> >   }
> > -static int hpwdt_my_nmi(void)
> > -{
> > -	return ioread8(hpwdt_nmistat) & 0x6;
> > -}
> > +#define NMISTAT_EASR	BIT(0)
> > +#define NMISTAT_EWDOG	BIT(1)
> > +#define NMISTAT_RTRAP	BIT(2)
> > +#define NMISTAT_DBELL	BIT(3)
> > +#define NMISTAT_EMSWDG	BIT(4)
> > +#define NMISTAT_GPI	BIT(5)
> > +#define NMISTAT_NMIOUT	BIT(7)
> >   /*
> >    *	NMI Handler
> >    */
> >   static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >   {
> > -	unsigned int mynmi = hpwdt_my_nmi();
> > -	static char panic_msg[] =
> > +	u8 nmistat = ioread8(hpwdt_nmistat);
> > +	bool mynmi = (nmistat & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;
> > +	static char panic_msg_default[] =
> >   		"00: An NMI occurred. Depending on your system the reason "
> >   		"for the NMI is logged in any one of the following resources:\n"
> >   		"1. Integrated Management Log (IML)\n"
> >   		"2. OA Syslog\n"
> >   		"3. OA Forward Progress Log\n"
> >   		"4. iLO Event Log";
> > +	static char panic_msg_uv[] =
> > +		"00: A watchdog NMI occurred.";
> > +	char *panic_msg = is_uv_system() ? panic_msg_uv : panic_msg_default;
> >   	if (ulReason == NMI_UNKNOWN && !mynmi)
> >   		return NMI_DONE;
> > @@ -189,7 +197,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >   		hpwdt_ping_ticks(SECS_TO_TICKS(val));
> >   	}
> > -	hex_byte_pack(panic_msg, mynmi);
> > +	hex_byte_pack(panic_msg, nmistat);
> >   	nmi_panic(regs, panic_msg);
> >   	return NMI_HANDLED;
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
