Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792990259;
	b=N2OD4g/yb5IPQNnGDcA88nPUqCTWE/k6nw3fMHPC/cX9sTzgtBHovamXUlE8bgbM79Uk
	 P45b2f9AuRSe2ndocZ/6T5N9YyaboUgWabtQ782rRxyu7XVSojt54MWaPYNVpgu/JRiYx
	 5VyegXuwDABZ+OMUCiHOknovTPuCEAP2o0UtHLcG4egU9xje9T3e181oq87Q1fZFoALog
	 YbMQqBfnDWSdglg5EGGLO7DFY2ja7cUFzzJf0yGw7dUioUfOmsUcQbShBc3V08yIQU9+F
	 ditJbANlDtMrZCqZN80GbWfYhvObfwGOLbCPdNyItcAQjJi75WS7Xiclz9yewNLMz7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990259;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
	b=NeqKyqAVcDrgR15xAS+vJBjAZ/h01cOXF1kbzdcicU9WFAEtuIvR9tBmvNnU0jETxph9
	 ky7AHefVEvCW/GUis82GomzlFKL+0pKEIiVgTKYgYpvWhUvh+vOIZbBheC5xxssVDP/Qf
	 i7pQNd+NEl4jQ/lQ6a2OnBP5PuG/aRzjejmrQeBi6YBJZBuvz08iicpjpG1deboAYS4sM
	 qUJU3pr7cgvc1WeBhU71Oipr/U9s3jBxt908hXjpSt9OJ6QPLFujfwKiMTMh1fdCJZ8A2
	 MzlcqLptWfDUT7/KkzxFj2GanLzDhCC1PRoYmCjFqVXzDjr9y3P1U0csXWgAOhdrjVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHSA6vnM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GniKnp2v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D030606A31D
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 04:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D030606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WHSA6vnM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GniKnp2v
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b7rp1907915
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 04:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=; b=WH
	SA6vnMeCiMR8EvqgM6oo6Jm+PcVod2kyYd0RTXrstfPX7B3R32jVXL1XESsGVPsR
	Nkmn2wkJ48nfu23C9n0UmaxhrHE0i0AIfVnDx4mXh2dlc/AevMLhtenFLnhfnCXJ
	1TiVRaew67e+KU/JDhT/p6+Z3BBl2vcVMBwq/5PmECq1ixQzOmijMjthIx4XuAaF
	A1SksU9VR02CqrAST/cSBURfou8lIdHAcOwBzTFoUsbvlBX0+a7yc+eov9YN56bu
	YSeHmU2N0FCEAPsWFdvvUNuiRGdZV0QWqoJqDr7fmEWqsU1C7ZKCWdJTtJjjIpj0
	9Qn0pINW4udquARjtmuw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gmv39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 04:50:58 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c4ca2265so4602285d50.2
        for <linux-watchdog@vger.kernel.org>; Sun, 25 Oct 2026 21:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792990258; cv=none;
        d=google.com; s=arc-20260327;
        b=s9XHvZTcfDoGmDkVv3+/OQN76Msf1L1rDcJmLyKpoB2zz5M/E2TZ/PbSCGVeUgsYiy
         xJ+J/xqzp5ixIOH50GdJA2/b3HWCOIVlAK7ca6y5cKz9CFEWrgFMQqa5ZkipbklnGDNA
         X3mcvT0d/tE4xjqf44xy91KdKxu8c9XOSOi50fx9PwxWeoaliebS3FfGKZn8XeJKm6GX
         A4cQkjDU1kYfrURTExq/JCLQoCcKa+cwlr8O3CRQapAOVurvZMJrRYneWt0VDUF8OWU0
         naQYL8L46mTRGV7j5mbSDpVzQdoO3CFqnLyI8AjeqHAyKYt39NMjRj+TexvNsej8HX4r
         WNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        fh=sdfVP0pa+qDEK4Y3dreRUhitGRJlWK6eRyPoyz/ls3Y=;
        b=iCluwe+mG8hk7mVcENiweR5kpCT8o9Zay+WzTS1ZYiyY5xwFl4Gg90FzZ6quWQpL5z
         V01zFzEydvPzmENMj9JCyNl676QRSOvVP8wrgahIrzN4NqajjegqYn2fySRGN7qLjsjF
         7wPSn8OYMtVULEcoZCTHf+7J07KkZUMkbnF2Zqjkvz/PtldoCs98WI+/G+G+HlTER70e
         rRfwRNaEV8bEApTAZZxm1z0Lygx4rmKcQlxRUqryed/4CUVl7RSXTAt3rXJVT98/PurD
         ldQ+vK59lWr0AgyHk5yjj32PdZFZ7JlrkSOJn/b/90FsXMKyt7K650YsNdIJNoAdVKKY
         dEqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792990258; x=1793595058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        b=GniKnp2v2PmvrxqAX6cS4Rji+TbzlsQo9MhFVtE/md2cewROEO69qmzj8b4n4sXQFn
         ileBFc0/EaAYzF9RDe0SMFod5pE2ONdE+lL1xDCDZG9v1sYHjBMuRDOYMFpD2y5L+ap0
         g3PzLMpbliiGwzZuX8Nk8JHXEictfSlcxTBV4b74S3FvoGn1kV1WnC2v38wVoGW6KUlV
         MknMTYJrJsmboc2rTcqot9FjNT2PeJhMnag0XjdrHkRyRyIGo8o/lUV2Gk5EcGpRk9Dw
         ZvpDLtrsEBOSipN6r4GSfgdR3hsPINFFGTDgrueioN2Nn7T5mFwb2pnotToXIwMQ8X92
         ewTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792990258; x=1793595058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zLeMuPnq+PRN+qUyA9Lb/wfh2++JYWPj9vtOQkTlII=;
        b=ncBHlM6pWu6hp12JhdAKud2GrKKn4JYhD5YL4d2O5JA6bllfpuOhr2pjj+TWmJfLWk
         5iJPM+XuID3jt4cxqBoMtxe6BHJYP+twf7rzP5Z+KjwATno/UlkFp71IN6b7McB/icKQ
         xoVxdXX+RfQL0UOtShm90/0EzjC/fAOzv/5FWu63Fsg66kjA59EwbCCoCKf7wJq0XnlH
         tytDCZDiy9cRSz2KHtKePJ0wML6eN/oJn715C7YeZcLlcmM3eeXbLS5GIq6d67rkzIne
         y3h4vTCLTQS8//UsnKkb9e9ouCn2bdCUkp5zSX0v1hT2vchlhvin+Y4eJP0AeqMpiouF
         t0fQ==
X-Forwarded-Encrypted: i=1; AKwUvByeEgEnRCWH9f91MsKFkLkGb2CWRnwQL/WiUACT6KjeNgQyoIjcQtrUaiuXU1tD7Ei42F8+Fvw5W+5gwq/NhA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIXZlwrW7gCwcL2+/Ejcyq9rydhpYTkQDLoa7yhd/2f2YUlniL7
	s06DIlbHkT27LRmN9WL5Lw4+vLUtc+OLR+8NAwKJYSo1ML1fGQHnPxmhXvUPLqUlWs4pgOizHNK
	Yo3BWhg0bt1TVrT+vs8h8KRPaN4+jLnguzzakhjrWGYmgB4brYU7TwJAztZw+2bVuekjxFaRH8M
	OokY6dwn1HuPiJy9sDjnE57BwLvt+P/2Qsjazl5HyIu+mF
X-Gm-Gg: AYBFou1Ta25Ts80vk9NzsDt/DZQPqy9zgb11QzNT+wX4HFklcc1zkOhWbLY3dVozPSf
	PyN5ZtWvohoDy0x/vqNl6sJaCujzCJY8vn5H7lx/X+YPMGmJVljClS0CsDOCc81tt7dW2+QaSaB
	ZvurLpzdB8CjevjkxkNptHb155sbebUEXPPa7G/rJwSNSo2OLpnseIvBwN4eY=
X-Received: by 2002:a05:690e:1182:b0:66f:d560:32f1 with SMTP id 956f58d0204a3-67a45498ae7mr3358061d50.39.1792990257596;
        Sun, 25 Oct 2026 21:50:57 -0700 (PDT)
X-Received: by 2002:a05:690e:1182:b0:66f:d560:32f1 with SMTP id
 956f58d0204a3-67a45498ae7mr3357961d50.39.1792990251177; Sun, 25 Oct 2026
 21:50:51 -0700 (PDT)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <arqSqcoWAkhy-8do@red-moon> <d1720b63-65bf-4019-bc19-1852555f7993@arm.com>
 <asieTvinZ7c2QpQm@red-moon> <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon> <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon> <athimRqtDvQu1ZzA@ashevche-desk.local>
 <atiAmZSPiRNBAO5O@red-moon> <7f077fd3-9c67-409a-b46f-7f28a55c180b@arm.com>
 <atmwo3Bpi62kB8_n@red-moon> <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
In-Reply-To: <CAJZ5v0g56LP+EQc6MQ1H_5XnQALEn3CV9Q9HGCoiuMvpkK+N+A@mail.gmail.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:20:37 +0530
X-Gm-Features: AclHuK-1DHAybX8n_MVkQPFIAt-ZTZyBKU1HsuPQ4k0q0v0UpqTvAKQZTHvj7-E
Message-ID: <CAB19ukGr39DrSXdR9Gy=YxVSXfPgYB0oqqjggQNBfedMjVtAwA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: lbwrwGsAifcNHKAuYGCgnFtcYMWGkZl6
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adedc32 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=67Uejn7MJG7rg031VH0A:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: lbwrwGsAifcNHKAuYGCgnFtcYMWGkZl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX5KYbc7mv+yLC
 5nzwiRsor70F8gqBk0pF1XB2AdIb6SmC23MDGxldbPk5TNYwE5uwaU7ciQmcS5lckUWOzXp7XYk
 srRX6GKbpyrJrLRnOXm+lPzR+FRX0gd7PLTlRvcxHByI/zwG+Noqp/F1szPROXtmsE/MmettMeG
 ftRrXJoaIZ7JwK2x2lOzyBTAV6aZUyN+vB7qI4w7AJdpUmnOHLPoXjXSSwvmUZBGmY2em9sR4zm
 gO0pabzTu6UpWuEsYIG17+s6tJO0Ht3GKPo+HfPDdkDAZ17vMEqi/fnckqelyS9GgTb9bf9k48W
 bNib/mkxJV6VX1In+BuvqsL4M2/Gj5TNLHBYr4R5ELVywwuGycl+nBw8kKz6r76IX1fcY6yzMFa
 3xbsuzKhKSHnqS3tuQ6ppvMGPST7deECdNkv7djCFJxLu5QPz5x4FplPViINwwy0kZI4whiin8I
 KT79wMGnk/PShGKtGFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxOSBTYWx0ZWRfX01JsmOsIbAZ3
 DOEKanc0IfoopzAissih5m1CRNY5VJl8DXSCbw7zU2Vhj4ZsrMn+rHRuxvfBX44GLJZOcGxe2+K
 a5ToGmvHPJ5kweyEsjaMOThjsV7bjkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260019

On Thu, Oct 22, 2026 at 4:18=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Oct 22, 2026 at 8:43=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@ker=
nel.org> wrote:
> >
> > On Wed, Oct 21, 2026 at 12:18:39PM +0100, Robin Murphy wrote:
> > > On 2026-10-21 10:06 am, Lorenzo Pieralisi wrote:
> > > > On Wed, Oct 21, 2026 at 09:58:33AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 20, 2026 at 05:30:00PM +0200, Lorenzo Pieralisi wrote=
:
> > > > > > On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (In=
tel) wrote:
> > > > > > > On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
> > > > > > > <lpieralisi@kernel.org> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > Basically, yes, the idea is to defer the creation of the plat=
form
> > > > > > > device until the dependency is met.
> > > > > > >
> > > > > > > > till the dependencies are cleared but then, without a _CRS,=
 where will
> > > > > > > > the consumer driver find the platform device resources ?
> > > > > > >
> > > > > > > Well, good question.
> > > > > > >
> > > > > > > > There are multiple facets in this issue and possibly some o=
f them have
> > > > > > > > been already solved but I need to pull them together.
> > > > > > > >
> > > > > > > > > Note that the dependencies can be added to acpi_dep_list =
after
> > > > > > > > > creating a struct acpi_device with acpi_add_single_object=
() and
> > > > > > > > > acpi_scan_add_dep() is not really suitable for that, but =
it should be
> > > > > > > > > doable if the dependencies can be found.
> > > > > > > > >
> > > > > > > > > > I need to have a deeper look into this next week but I =
wanted to ask first
> > > > > > > > > > whether there was something I missed - most likely.
> > > > > > > > >
> > > > > > > > > Well, it is not really straightforward.
> > > > > > > >
> > > > > > > > Yes it is getting messy. This RFC, with all its flaws, does=
 not transparently
> > > > > > > > prevents enumeration but rather relies on -EPROBE_DEFER to =
sort out
> > > > > > > > dependencies - though it does so by adding more stuff into =
ACPI static fwnode
> > > > > > > > that to be honest I'd rather see gone.
> > > > > > >
> > > > > > > I think what you need is a notification mechanism that will t=
rigger
> > > > > > > when a specific device (enumerated via the ACPI Namespace) be=
comes
> > > > > > > operational.  It doesn't look like any of the existing ones (=
platform
> > > > > > > device probe deferral or ACPI device dependencies tracking) i=
s really
> > > > > > > suitable for your use case.
> > > > > >
> > > > > > Yes. It might just be a notification from ACPI core to say "the=
 driver for
> > > > > > this ACPI device probed, go create platform devices that depend=
s on it".
> > > > > >
> > > > > > We can check and track the dependency in code that does create =
those
> > > > > > devices today.
> > > > > >
> > > > > > I will think about this to see how bad this might look like.
> > > > >
> > > > > Don't we do something similar in drivers/acpi/x86/lpss.c?
> > > >
> > > > I suppose I can add a notifier that checks whether the device whose
> > > > companion represents the ACPI device a given platform device IRQ de=
pends
> > > > on was bound to its driver and then map the IRQ and add the platfor=
m device
> > > > _then_ - after all that's what acpi_dev_clear_dependencies() does (=
similar
> > > > at least).
> > > >
> > > > There is still the question - where the GSI number, flags should be
> > > > stashed so that the notifier can grab them in a uniform way. We
> > > > could simply attach platform data storing those values to a pdev, e=
ither on
> > > > a per static table basis or generalize the data so that a single no=
tifier
> > > > would be able to deal with it.
> > > >
> > > > That or I can just piggyback on acpi_dev_clear_dependencies() and a=
dd
> > > > a separate dep mechanism to acpi_dep_data that instead of being acp=
i_handle
> > > > based the consumer is fwnode based (something Rafael mentioned befo=
re).
> > > >
> > > > I will have a stab at this and see what's the least bad solution I =
can
> > > > come up with.
> > > >
> > > > I suppose we are scrapping the -EPROBE_DEFER solution (ie this set)=
,
> > > > what we are talking about above won't need to defer anything other
> > > > than the time when platform devices are added.
> > >
> > > I dunno, that seems pretty drastic for some use-cases - the fact that=
 a GSI
> > > is described in a table doesn't necessarily mean it is critical to de=
vice
> > > operation. If we don't even create the device until all possible reso=
urces
> > > are available, then its driver never has any chance to decide whether=
 it's
> > > happy to ignore the deferral and just use MSIs or polling instead...
> >
> > I agree with you (but that's what we do for ACPI autodep and AFAICS OF
> > devlinks - though there there might be opt-outs).
> >
> > To make -EPROBE_DEFER work I have to pursue the approach undertaken in =
this
> > set and apply requested changes - I don't see any other way.
> >
> > Are we willing to accept the approach taken in this patchset (I can rem=
ove
> > software nodes and make the whole thing ACPI static nodes self-containe=
d) ?
> >
> > One way or another this ought to be sorted, please all let me know your
> > take on this.
>
> Please make it as simple as reasonably possible. :-)
>
For this use case, where platform devices are created from static ACPI
tables, I think adding fw_devlink support to ACPI is a much simpler
approach. I proposed this in [1] as a generic solution, but we later
realized that it doesn't work well for cases where dependencies need
to be established very early (_DEP/autodep worked better for such use
cases). That limitation should not apply to this particular use case,
though. So I wonder if a combination of autodep and fw_devlink will be
a better solution?

[1] - https://lists.infradead.org/pipermail/linux-riscv/2023-December/04614=
6.html

Thanks,
Sunil
