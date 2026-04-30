Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D67374E67
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529756; cv=none; b=LrOq05BDjPmLQmidy3JILQDiyRm7x9L14JJigzEc0kFxluiQ+kSzm77GTVfvSDzdzYwEmDQeJsKtrA9Cm4bUNQP433OTaQZ3vLolaKu5j9Y46F8Qh1ShFKH9I2FEYEucyW174nwHNBBFLOUf3XM3mrOfs8QqMNN/CnOATCAIufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529756; c=relaxed/simple;
	bh=kmbX0XTPH+khESPujp6eG9FWEPnrJtDuQREBrSqGWmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsGoiK6uc4ZC4s97ME2jtXzC86BibtZ6gAhY8A5iuW9LvHRLtsAFsFUD2OMfUn6eH931EyfMoyuSfjT7RRu1UoRAIktUN3fluNLPxVkG89df58tydhS6BZJZ0Aatt8AkmMKKmqZ7FiGfnCNOZKnaNRE9O2EMs1wyTkm2e+z/prQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c+sdZ+sf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VAZsU/UH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c+sdZ+sf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VAZsU/UH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TMFM503886235
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 06:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XI1Ys6X0HzEWeMMx6Wwm+y2i
	RQ92XxBIvCwJWthvM+s=; b=c+sdZ+sftVuHDMkQ1mj/sYX0jcgvMDxXKsVHoKSi
	d0C8js75C+bVRjeS2UjD3t0YuFW1lS/Kbu0yhrSfZ1fXQl+1q/6IgxEkKd52CjmT
	dth8t2AsBScFbCxKSQrVwokRVPSZ1Vw+/UZ9HRQ/Lr1ow7SDpvLzVldDQS1qK8JE
	Gj48nwnQtJPwYC1Wikly3cEgBzt7Pwi8mMJ/U2AIoS88lSEPkpZuaWhWoN2Wkn75
	NcRReXSIyGYqaQGdPEalC3s7XRdcO8mJ5DdDUb1Za1SZNV7ir0vaS2F9XyXndHDN
	2EFYWFekccNpDdfhi1jfKPfjuCHEQNzRYbx684s/alQbWw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmah8xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 06:15:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so491155a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Apr 2026 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777529754; x=1778134554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XI1Ys6X0HzEWeMMx6Wwm+y2iRQ92XxBIvCwJWthvM+s=;
        b=VAZsU/UHVHUoLSIS10TIvhw1fEgUtPUL1HSymX3VmOoCYrKaSISVpPeaeSsIIkfa9W
         7JYTRjGoAWgTS6CIcBYy1fbvuzjer7xi5+HuXDQzmX1dW63CV8Ii1+9loNuDb81p1l41
         gp6/zZwHloa8SlF2OkFUo+E3ObWUF/+8hBEVuzGkyly0LR8cpDGcO/GXX/rZhZQzZJ5Z
         IreeEhu0ZZSo5kO8o3B90/LKW9skZG6RXxOfJr4q924TXJqg2jOu5yTQUAbI8RCFcD8e
         lo1blNVIbv39vEomY5CEXpS8eRhQT31XSlhmW6K5D2Ll9I3e0c5RXrk845o0/miDBDQH
         dsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529754; x=1778134554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI1Ys6X0HzEWeMMx6Wwm+y2iRQ92XxBIvCwJWthvM+s=;
        b=SLjHBjE5RYJVUiiNFLmmlh7pDTAvTBQKBKhvcBBcAGxt4yStcRdY7pKRjm3hC1Fkz2
         yIzlPh8FFALiVbnyqpfPAp51n6+wJBb1ZCoILcHA5p2EoSCPVUlsuqmzt8Q8MhKA7vO6
         Do/LkjbV7Tt1ddExFI7JgTHkO9JJaEEF30n9/kagLWL6gkA7dF6wHTya8oeWdmE25c0S
         uF7Ek2WVLfgwSh50TU4fJYyrrnAs51Px8V27MV0JHS/2RDLoRUUgoaZA+u8jfz7d3dk3
         qlYTLx7gSodPnmrkVhmt+YvY8yRj7vG+sWxDNoMV9H5Uz70ny3SuImfztHj8lGJBjsxh
         yo3g==
X-Forwarded-Encrypted: i=1; AFNElJ9zNBsLJfVauATAZ+nnw7zyDbCZXiNNywX6iIH52JNwfyRrZrOjddaBaZIo1zDMMVX6FYC/nadx582u94FogQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDKgnoFs7l6C3mXuWkdibG/F/INroMavIZq2CN4t8kmh6t+fq
	BMUgCuywx5JtZ0hEIZTs4Ggf7XHNvWFd8OKcxAb/CIfuciuR5N2PXPw+UomD+SEYpdxtH0hAAtS
	sDFh0wM+th63aySRwARaaZDaE8Yua5UX1/PfwWjFhajyfpLHDEJ/XRyi/zsI1yVgRwvOGig==
X-Gm-Gg: AeBDieuEvem+Lqc8iZwf5PUc2v2qNLedNbIEd4Ib5kAOa5TvfFohyTTp8PkajqYh9Lx
	fODYI71ajj4JYD9fkEPZLpvk3B2q7IcLAmG8bgTo7/oLIKseemA2BfwS9yCmZjQhHWzmVTWq+/K
	bW4JK//7qFZ12MowYGm/XXqkWOUsBD4HNL3FqjBwMj5hua6TdVhVDXn/z/jFWiY54riyQtiwIs9
	tzWubayHPMc4cIKCJvyjEjD67coIEh36/2u9zePucK/ezAChhzosTCeDfe0ory51OGlEG2wrtPQ
	yFG2/hIOuBy5HxwOEFQaIJ+WgRHNOahd1HKLSPv9Y+NPRdFeC3HLwMxXrMsF0jMVqH8EHctHsEL
	h+sfB6SoQGzk285ZZXL3WKqPo7YCF03BDENHFevRzbp3vFZjZbIEF4o8RaNSHgRemnw==
X-Received: by 2002:a17:90b:2810:b0:362:bd99:8813 with SMTP id 98e67ed59e1d1-364c2d85ccbmr1463908a91.0.1777529753971;
        Wed, 29 Apr 2026 23:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2810:b0:362:bd99:8813 with SMTP id 98e67ed59e1d1-364c2d85ccbmr1463671a91.0.1777529748708;
        Wed, 29 Apr 2026 23:15:48 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772ca0sm43712725ad.11.2026.04.29.23.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 23:15:48 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:45:42 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v8 2/2] watchdog: Add driver for Gunyah Watchdog
Message-ID: <db85ddc1-b302-45f4-be26-f835c63ef069@quicinc.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
 <20260311-gunyah_watchdog-v8-2-4c1c0689de22@oss.qualcomm.com>
 <acqEc_urKggA5s62@baldur>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqEc_urKggA5s62@baldur>
X-Proofpoint-ORIG-GUID: F_HIdsfn0hPjJfn17maOVwgPZV4yLe9B
X-Proofpoint-GUID: F_HIdsfn0hPjJfn17maOVwgPZV4yLe9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA2MCBTYWx0ZWRfXwF9bEEi40Vxl
 zGIzRYiPBSH2QxNkVvJ9o8AJDD/SHb9s8D2qP6BbKh4zv1wFVBoPMYpBgxhh0wcnfxSuuAXwwZw
 PfK5+UyA/7Ce8oyeNITCkPQeUSt1K2nAYz+8c/2ocGgnTFKwLgeQIS0qZnJo0fbvnQk29BIyS0n
 8jmp/Qg/L4ajC6eWzBz/24SPiAa3kuh97OKCSrCFK1QeEPRbIO0svCHOolrFf5gxLot/Pvm22xr
 hA7FTaDKBu34Q2EP6CMxI/moeF+wMNoJo0ZyM+NJSWZIxFzjv6U54pjbu9yk1AdTVmaEnwqoCAo
 c9+pmHd+OZGowkTmNFS2rBt5jc2Y100xflD1v8eaGk34EyEvVGVdHAl4qyaU9Ogccy4OLYoAnwv
 x2AriX4S9wav993/twm6ErVRKAK9VPoBlaWysF87R5LHYJhvbFrjil6G5hw/lLc134FeeZORFw9
 08z+LgUiWlmdtDd/QKw==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f2f39a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_jlGtV7tAAAA:8 a=Xunf5EVzr_mzzeh-NLMA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300060

On Mon, Mar 30, 2026 at 09:11:48AM -0500, Bjorn Andersson wrote:
> On Wed, Mar 11, 2026 at 11:16:31AM +0530, Pavankumar Kondeti wrote:
> > From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > 
> > On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
> > through MMIO is not available on all platforms. Depending on the
> > hypervisor configuration, the watchdog is either fully emulated or
> > exposed via ARM's SMC Calling Conventions (SMCCC) through the Vendor
> > Specific Hypervisor Service Calls space.
> > 
> > Add driver to support the SMC-based watchdog provided by the Gunyah
> > Hypervisor. Device registration is done in the QCOM SCM driver after
> > checks to restrict the watchdog initialization to Qualcomm devices
> > running under Gunyah.
> > 
> > Gunyah watchdog is not a hardware but an SMC-based vendor-specific
> > hypervisor interface provided by the Gunyah hypervisor. The design
> > involving QCOM SCM driver for registering the platform device has been
> > devised to avoid adding non-hardware nodes to devicetree.
> > 
> > Tested-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
> 
> Guenter, there's no build-time dependency between the two patches. I'm
> applying patch 1 through the qcom tree, please apply this patch through
> the watchdog tree.
> 
Thanks Bjorn. I noticed that 1/2 is available in v7.1-rc1 , however 2/2
is missing. Guenter, can you please pick it up for next release?

Thanks,
Pavan
