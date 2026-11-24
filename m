Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511596;
	b=FMVTOm8JUtxHhCCem7EELf6n+XsB7Of1iKNYFFG8QICRkpzsLscTflfrUVdezpnWxmJb
	 wGzkZ5fJphYQpuBj6vKNbXEVaWd9WWHCyTpZDQd6sGagEwxp9M/9mnE3NQRL5xLBePUMM
	 OP0d9IjE3FpGPd+gooFM+DowN2zgeRy0p+dJRTOy1r/jlV/4SeNk3lblpw9ntQnqIMbRg
	 vfxnzss8a4hPIWISm9HshxpbMAFrK3VpYYCu9Ua9TJu9KWa8+XF3nGeYUQ+W2ZVsZwRr8
	 I3dPu/vUm9gALkYEboW9M3znTsDNfEjhj+98eRcaQxHySZtD+PIfZl9U0ODROPdlKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511596;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xSsbExyRgnMf+870sb8Orxcq7FevQGTwTXR3rzktG7Q=;
	b=bOE/R4uYQm4MXoQql0eyL33N5JlpUBNgyFADirKFdYLO2hp3wrz0X+MHnXG5jheNsbWT
	 VDEFiGHQBqI8qOTLYA9Ud8c7aQ1b5em8oxCZULp3scTfXzgENZCPYez/DgHmlalwC0xQe
	 LMY0cTZwyLDVX/rNPjNxIE2Dtm6/a7n1c29wl7G9A1SxhJlGAVCDBRw9p4WgvqLPYFBH9
	 jstXE4Y2BFm7IrrmUWrI3i/0rxsM45HLDvs1URW+Mbh5PsfYxvT+maKcFLCY8jOlzdIII
	 ksKHx+M28+80uPGm6g9tJeirNp1I9j7QKCGwvNcjuvzFzsU4IKuF8btIWsEV/XukkDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihL73dio;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B2606A321;
	Tue, 24 Nov 2026 09:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806B2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihL73dio
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34t3q1217161;
	Tue, 24 Nov 2026 09:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xSsbEx
	yRgnMf+870sb8Orxcq7FevQGTwTXR3rzktG7Q=; b=ihL73dioksztXNZnGZbjw2
	vMmp1i+5gD4IytODK13i1tm3UiSXhtQejWRwEEFHDxDd6KasikNSpBGwzCiqMW9y
	l0n9xochs9ZjDrxfde70KqEmxRLFzgp6+tNoi2l9Gss0pN1GbNrXB9scWCOY6rEb
	53W0T3RREPteHzSKIGXLX7HqYVDLmnpAFInxWI4Zd9m4zeC5oxXX2+crsyV+L3nz
	sX+xSunzxYef/0CeLHORk9wFcow+nEUjThTEF93AYX4nLlbFyf/aUzeyLA6Q1yWv
	SNWZmQ6sKyDoJEVcMRCie6z+h2LXF48WAYeX7XXeKiEdxe1VRTSr4AqPRMbFrerA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv6kfa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 09:12:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8rXAt021968;
	Tue, 24 Nov 2026 09:12:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk20du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 09:12:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AO9CZVm3015528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 09:12:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2FD158052;
	Tue, 24 Nov 2026 09:12:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3780258054;
	Tue, 24 Nov 2026 09:12:27 +0000 (GMT)
Received: from [9.43.57.13] (unknown [9.43.57.13])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 09:12:26 +0000 (GMT)
Message-ID: <80be72d2-c357-4709-aede-a030e6751f25@linux.ibm.com>
Date: Tue, 24 Nov 2026 14:42:25 +0530
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Use wdi-gpios for the
 watchdog
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
 <20261124050118.87944-4-pepe.schlehofer@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20261124050118.87944-4-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b055505 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=VPMLOkGST9yvVNcXXMQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfXyh5/t0L+cfiZ
 8dY9+ntlJy9nMb8kW/Kk6FSRM6YaGcb/sE8DSmUUV3w9Zoxh4RpkT3O9V2SS2FVSEX1VVliERmj
 WPK3BZ9QXnpAPuGZZ5baH6P7HnDXbdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNSBTYWx0ZWRfX1nq9qCieY781
 I0vSM4rsVO8F+5RQlfdmK0Bv65ydnU+esyZNHdRWYucAnNIEkNBEg33aQbDn0eBp2lrurAnk6x0
 ytouiBYyBVe3Fwo+QRPbeFQyg3kL81HyPf57AvhXVN4QyQoKc2Py3LmHf8eTd+fIszGQlqZI3DN
 C9hXFjgEqb4/hvsXak82gfwyojPqmXggbGOAJTZ1uCyMbKVq0Nq5PHmbrKh+7BjlB4RsT2JoWKQ
 AbHIjelxUrw53iqwUHs3jqv5hauN566AHaAtUzlW8bD6Qx/iPaeF25USGrLeWL25l2Er9iKJdWT
 UyJp53Q88fxf/n6Hh8WylFt8aIQDq0a7AmKZaLXqTGq5zbO99rpqGMMCbG+usBB2ngMXJjvtOR5
 DCELC8J7tYmhZGJszQoRjME6mpaL9mQRMVjls0CgrFpjYuW9I3qQzo0DnU4etyZVZ1+bs3eWIOS
 v9h/L5MRkF+86eMUsVA==
X-Proofpoint-ORIG-GUID: 5blUheAGpVWOvEiAQCnnklA3GVUVcbJB
X-Proofpoint-GUID: K3ywaFCt4ZKf6N8a2r1PcnE6SwWAnn0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240035


On 11/24/26 10:31 AM, Josef Schlehofer wrote:
> The watchdog node passes its WDI GPIO in a gpios property, which the
> maxim,max63xx binding does not define and the max63xx_wdt driver does
> not read. dtbs_check reports it for watchdog@2:
>
>    Unevaluated properties are not allowed ('gpios' was unexpected)
>
> Rename it to wdi-gpios, which the binding defines and the driver reads.

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> ---
>
> Notes:
>      Changes in v4:
>      - new patch
>
>   arch/powerpc/boot/dts/turris1x.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> index dff1ea074d9d..494a96a1f78c 100644
> --- a/arch/powerpc/boot/dts/turris1x.dts
> +++ b/arch/powerpc/boot/dts/turris1x.dts
> @@ -363,7 +363,7 @@
>   				 */
>   				compatible = "maxim,max6370";
>   				reg = <0x02 0x01>;
> -				gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
> +				wdi-gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
>   			};
>   
>   			reboot@d {
