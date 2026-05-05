Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD878388377
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777951596; cv=none; b=jIWp/iYLJcuojeRq6GTZk8mHjrhuLbK8dJS1q51klg5zMUW5RI+TJA1jdRb0H1DhbA2UNfS/u/ZhFYJFmUB7UbVyy90fhEegzoKnIZyHQWEtJzcKNYOXZYk1lOEqgDWTELTT67j+95qFWoUMvL24+IaeyTN2oLjs8rJfDZLCqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777951596; c=relaxed/simple;
	bh=H5BWt0g+lBHcqIDDq+DPw1/YSp22G7rvCg5jlFjVQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI59NeBBeT9PTYhSAm46Am2seCvCwy0TqV2l7Y3BWbjbScg/6B4JQgWz1nlax1UbWXStJE6UTXMEonvuMAXFX8CihcZ7A+CVOAXsXaiFJBwbLzU4lLx0i4pp06Cjm6w0qP28JHXRQBUMW0SntLX/VRzutDE4UfXbUHe4k4KPcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=giiji2UL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bzwLo/v/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="giiji2UL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzwLo/v/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644IhVEg4128663
	for <linux-watchdog@vger.kernel.org>; Tue, 5 May 2026 03:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0eb+03iUL2YtyQx4w6auTRUV
	x8sUnU42H8ebf0/4g3A=; b=giiji2ULCti+kcZmkIWWQDNp+8PmSiSolD1Ufk0t
	JUl7+HUNTEtcOIQRzte8ThEP4dkmY8w3INSW41CYXtRA0rJCsEC021UFBwYiP7ig
	oimMpEopWBrxJaG/1Lt1R+8TC09RfNrS6mnUQdi6bBxEpCBaZeJYKKL5JRFAOazA
	8iTHkjER2/fZ9NEs3XPFC8rTB871j8FBwEcS9MrzAWOyIIS8g7Ku7c8naK65QiHg
	d9bqBdyMvvsXJTwjji2aMiBM3uFmMgYAvy06yqHjoDSQlHSv083h35+3BcfSe6Ye
	SEnnSdVppcQ9EIvIDsC729aPe5ZTyhQXfm6cXI+80e5WXg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsdw36w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 03:26:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso43762215ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 20:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777951593; x=1778556393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eb+03iUL2YtyQx4w6auTRUVx8sUnU42H8ebf0/4g3A=;
        b=bzwLo/v/lb3aQyUjXS/7J8VJqKilZfXeeOHP1rDGS57CHiXX5eMeKz1qe64sz1ufWi
         Qot7wHwrVyNg94Iq3L/R9wIIx0t7WACZUGE6veCYhrRj4jCphTPR+qJdaRQUiL9lqXHe
         VzbOMbcGxdNYOFNT3GtZ1CfvLXWyyQQt8gwQglm4hwF1Glb6GvL4a7h9TBVlZEeyutAJ
         XAPhPgNmBj3dAu8EroMS2qh7dewn9oqinsQwEoLvEuQpSxkUCSncJ8Ah1T9yUrOzNRa/
         RzBkjUIvgl7ryKi44s1P6ytp1I233nWKjqoUEpIRaKS6OBowhOalZV55qvIIxqq1a+6a
         kv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777951593; x=1778556393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eb+03iUL2YtyQx4w6auTRUVx8sUnU42H8ebf0/4g3A=;
        b=edyt9k7Sx5TP32g377uciF8WVOO+P9DcQL7vCIoVNFnSs2Ylt52mguavAT2TjAslfL
         OhIqSoLCMwoPaEzUuTbPThDjWBIIOSaUQMephYclCKUWAoPK7FWrNbhYjZRtomN7uKG6
         k2x8M22NZ4v2dz6Jv74K0DE+WwYRg3DPCcV8ILGHi5BW2uhnrm7Ux/yZaOs/enUul5/F
         fThp/EetsIa1EH7JjP18or1uW0CNuhT8e4xd3dCT/zSexfoPWkXIGlghvIKhEbfhu6rQ
         Xad2QI7DlewFro6+QqE67SU/482QysOhx0DD+O/qNCj3A+YBPd12l9g/FW42rz7e004s
         X65Q==
X-Forwarded-Encrypted: i=1; AFNElJ9UjqQivHi1ovuweoLimMs50gGHmJfJ0anC/tfa91ddazfjTYB/c/oqv9B++mtKZzGkY50zC3GyiU6ZScliuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHvLgsKOXDFUPz1QruS3I3yMUQB+q2VD8koBTbbc9B+XAb0oh
	QXFBFAVCE0Uvv8IMKiJKbG4qbpwLHHCfoVUGMmYWYvWaMLYkU2/2g6HqDRm+U7xZ+Av6iRo5WDC
	E9MvtffTq3U4SmCDzKRd36TyzZRjB1atWWAuu/m0VrjkYWNMe4V2uC9JmCHoE9HxHvks0lg==
X-Gm-Gg: AeBDieuC2jTsavlw4GmwgTFW6DJYf+Lma0iBWRbiGuyAp0Mk5bsk5uSJiXdVALEDb2l
	ZX20OhKV4P3dKoc01bzIKOkqR2ubPMYjalLxKcx3FNwZolCdwtWvKO/0dPp6I/TTXeT1nBt41TH
	A16a7BkJBklLuo7c6fUr7a1v501Z3WbZU4B5fpFx61LaPQnzD84SFfALM8Eaq2w+1yk8/vI4nQ/
	qKejpeJDpVU3kVhL0XmSXu3zycNViqcSDHLheIbXeqN71p822/KzHArdDXD+4Tb0RHF/Px/32Eb
	l0MKn5p+BB1WNd3obAipq29p4lWgqBnOX3tKCbR0ZCliyfYHomblzKqn3XjFoH8Na7ZAZRCWy5j
	ZXIvmjZJ7G73T1O3Eyz8VqlosBHJwuBwUMTxV3SMt3RKNtObqxR0dgr0PMGWX2rYK7A==
X-Received: by 2002:a17:902:e545:b0:2ba:22db:e1e0 with SMTP id d9443c01a7336-2ba22dbe33amr59277235ad.10.1777951592609;
        Mon, 04 May 2026 20:26:32 -0700 (PDT)
X-Received: by 2002:a17:902:e545:b0:2ba:22db:e1e0 with SMTP id d9443c01a7336-2ba22dbe33amr59276945ad.10.1777951592039;
        Mon, 04 May 2026 20:26:32 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f57sm118554935ad.77.2026.05.04.20.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:26:31 -0700 (PDT)
Date: Tue, 5 May 2026 08:56:25 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v8 2/2] watchdog: Add driver for Gunyah Watchdog
Message-ID: <38fbf5da-abdd-4951-90d2-941f7cd62299@quicinc.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
 <20260311-gunyah_watchdog-v8-2-4c1c0689de22@oss.qualcomm.com>
 <acqEc_urKggA5s62@baldur>
 <db85ddc1-b302-45f4-be26-f835c63ef069@quicinc.com>
 <f2386cf2-c790-4ce4-91ab-115a29399e25@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2386cf2-c790-4ce4-91ab-115a29399e25@roeck-us.net>
X-Authority-Analysis: v=2.4 cv=a7AAM0SF c=1 sm=1 tr=0 ts=69f96369 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_jlGtV7tAAAA:8 a=W9u3MqBc-PvxWcKrJdIA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-GUID: jwMHfrUfm6gqU02R18bZfvwdVWwBQ0Wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAyOSBTYWx0ZWRfXw9y5bfmTlk7x
 BJcqLvEyg3hAASHziOkvjkDOKjc4auZ+Lc5WzeAU9BCFsnIrPN3TVLioTrUqRSF/dU4Q6cgaN+A
 AzIFD8Io4pw8LnC3AVpnTkIOis7Joq6PLeHLD1/hhXsK6TE0uceBOXqr7o+HNweF4F/EZa8DoOI
 2xsHwRiiFhGw1oLl89EZfASUzx1V65eNnWKCb6IJzJtkXcsjehozlhMLfWkeYSDwuqYdrqS56A4
 /UoMqTUYqymQmOih2dtPvGMLxCBF1sv8xyC3ETDYaU064YRRRE3CVMPNxg+L/CxtpZvJA9UUhV/
 iN8374HomvLJWYmqilTERmSKOeP8UiBo8PX0GYTp5IGoSaxS4mZOK9e+MigCnA3WCjWjfkWtDRN
 LWWxyjT5lChQQyltAGKUu5viq1NIcYeB8lKU9A8fl6w4lKRSf+UFfQfIoP/7AF+F5CFjJ0vpuKL
 Qw4NRum4OxGmAdbkgzw==
X-Proofpoint-ORIG-GUID: jwMHfrUfm6gqU02R18bZfvwdVWwBQ0Wl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050029

On Thu, Apr 30, 2026 at 07:37:12AM -0700, Guenter Roeck wrote:
> On 4/29/26 23:15, Pavan Kondeti wrote:
> > On Mon, Mar 30, 2026 at 09:11:48AM -0500, Bjorn Andersson wrote:
> > > On Wed, Mar 11, 2026 at 11:16:31AM +0530, Pavankumar Kondeti wrote:
> > > > From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > > > 
> > > > On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
> > > > through MMIO is not available on all platforms. Depending on the
> > > > hypervisor configuration, the watchdog is either fully emulated or
> > > > exposed via ARM's SMC Calling Conventions (SMCCC) through the Vendor
> > > > Specific Hypervisor Service Calls space.
> > > > 
> > > > Add driver to support the SMC-based watchdog provided by the Gunyah
> > > > Hypervisor. Device registration is done in the QCOM SCM driver after
> > > > checks to restrict the watchdog initialization to Qualcomm devices
> > > > running under Gunyah.
> > > > 
> > > > Gunyah watchdog is not a hardware but an SMC-based vendor-specific
> > > > hypervisor interface provided by the Gunyah hypervisor. The design
> > > > involving QCOM SCM driver for registering the platform device has been
> > > > devised to avoid adding non-hardware nodes to devicetree.
> > > > 
> > > > Tested-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> > > > Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
> > > 
> > > Guenter, there's no build-time dependency between the two patches. I'm
> > > applying patch 1 through the qcom tree, please apply this patch through
> > > the watchdog tree.
> > > 
> > Thanks Bjorn. I noticed that 1/2 is available in v7.1-rc1 , however 2/2
> > is missing. Guenter, can you please pick it up for next release?
> > 
> 
> I don't send watchdog patches upstream; that has always been handled by Wim.
> 
> Guenter
> 
> 
Thanks Guenter for the reply.

Wim,

Can you please include this driver (2/2 PATCH) for the next release? Please let us
know if I need to do anything else?

Thanks,
Pavan
