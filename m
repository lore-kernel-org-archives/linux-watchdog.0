Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E143093BC
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211816; cv=none; b=LHCMdRnPgkAmSAADB3dEHQJKJe2SbtTb2P9U4zUyM2Hcth1FfkxWpBh4oSKX7hEZx2sVl8vm/XD448kY0QABZ0E5OMMNShpkLXjjQt8zvFu4GKjbIVuRcK4VM2N9VgwLwNIxYNhgh+6i7hORarIz2unTekhu96alPAjPu5rO+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211816; c=relaxed/simple;
	bh=LDI5IRfqOf9kJrBtPimUf7w87PMx4XjVNILUEYeSwO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN9I8m+2RsSG9ir/Tt+PAYM9F3wPWGYdzdftH02eM2wyo5DPhs/NhEjI9Gapsubeh42mbVoyu2ne/Ut8xWVxk7/DbkC4z2fQbkZqOOI3shYE/4QvC3nHE2w5muqS2shLjUK0lNRzDW7cuEbadzpQFJty2lEpijiBBBavOnU+TAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lIiekHoS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQ6vG4TF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIiekHoS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQ6vG4TF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B6MRP61863245
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 06:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jM+2RSWSrX9q7YEjv5odBisi
	s0iO1XVRbBwhJmNg4sk=; b=lIiekHoSZAK2khYRVOSkm5ksmCZalEz+s7C2xTTh
	CkOoBL9tJtPf1GuPN3ckyCjp0XO83ZWBmwesvaxzl94DEh04ArZooxEiNh9sJYDn
	6S8Pukl2EhOlEndQse4UsJE8NS+RQ88xGSEoygiT8b9SFLObwgK7U4IgUaq6v0t/
	5kY4Pjz4v00p9YE82u7OT/jXJ1y2m0ien64P/Iigh1fhZY98fCp0g3P5SQcEqZxa
	ZhjHqU730ThSrHLA/LxCBctX7fXbHxI7jCFoI8L1b4SXyZyxBeN8hLAZuMYGJM1P
	MhR/mtuefYv+GLSYkhaBDF0GZlAV8GkGWH7NIHSIa1R7PQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw835v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Mar 2026 06:50:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae6dd98043so71157755ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773211814; x=1773816614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM+2RSWSrX9q7YEjv5odBisis0iO1XVRbBwhJmNg4sk=;
        b=iQ6vG4TFn/vazkRK/yESRC2YRQCh+CTMf24iZfF3eIwzpsz1256guvehFcISoVwNLA
         dddloimgqn25VD36kv5P4os46qzG8BwaaBC0TZEtmxmqFnywX/UZ2Jym19XSlyKioRN8
         ygGU/yjn1gfJGHmmVRAoreB+EH745OEgBQ5bjoQBriO7/8AMbCNSbCtqVu0EewisnIEP
         TIVT0EjbZfbE8RCydFPJ+MS1Z93nBwGFlggK4/n9+9biookFcyMm5zna5fzcm9Gfs8ja
         eMFAKkMY9wnXsrbNjBlJJTDxSWpn7nLLU6vaK0oT1Whul+BZ7x2xrqhlvUkj7SY7N7S1
         LWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211814; x=1773816614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM+2RSWSrX9q7YEjv5odBisis0iO1XVRbBwhJmNg4sk=;
        b=d71EwEEnquBHCu+9P261WtsEw8MxKo5hM02nwNEKiCl5VxZj86q1bLPdVbNFNJLhvQ
         AJUkS/+YIkjykVblyNjMIen7Jrf1EEfImrfIzg+C1BalSA/zS+HJdn0mrH+EBJXMoLkV
         W74XzZdyAgt95/Nn9TbfDG4uroRS86vsTJz0szprCw8yHdteIHknOBjra8SayxWuSTul
         RBOhTP3dTvcmRy/popDs6H5Jb/73o0dicb/coKh8xQQVOWB2IfkYa59jvrfA7HHj+LF6
         lL5PESyr9cR+aHck7Lo6/ziCSyjXjLxVnfa0UTFIY5QXqvbX9PMhZP6k+jy8IVZJZbQq
         kszw==
X-Forwarded-Encrypted: i=1; AJvYcCX3J1TVPqy4nuw5ak3xf1E0EnmIwMYensAsceuGgvzNLHddcwGv5LyUbG53prYeWb8EB/K7dWYiFFTF1kHyKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPnTeWOrZJLI0gCsAobthmXrkbuFnQyLEjGDcnRx2FMdl15Xw
	vzF8hTBK7zSJ/yyaKkx/Z7VdIMD8YuFAgMLWmPVOkls9tJ/JsL4ykpqpPv0Cv6RXjOQacWpSx/e
	O1ZJbTEwOVy0mTKHOo3NyICUAwUhoP0srDF+BaL+5nE/PdO6JyfxooOY//vBCiYWX5R1YQw==
X-Gm-Gg: ATEYQzxHlXY7zUl1wJsPGgX2RvcE0fdQYhHGNs0n6Zhk5K+GqUuKr7XrKYozrn5aej4
	TvjPedeYnbuKszOn5V8jXn4L1yF6mGDhQKRw67MFCJMjCV7GnQJaNmbshnUiV4GZv4JJEikAqlr
	1YsnB06Jq8aRH7dIMjxs6qKBbgCGPhC7rgq5Y8HLHHfU7CtEogtLtfRUv3XN2onXrQSeNBNfuxp
	5JWohdKu7tN2mj5XVN1EQknoBVRHqgsjjSt8bMMH0vNr85d2rpwdNAmR/QGL5xvJIXkIPHwxrMr
	YrSDloogU/Z9rjtEFPGmA+W5Qqe9vx/UzMRQBrMUi9tVK4UWy9n8aopXj9yddchqEM1Br1Qp2IA
	0eG1yi8EA/C5oPh0FSwbLzbFmfaPOkJP5qQPDWCZn9dJ047+Z
X-Received: by 2002:a17:903:2ace:b0:2ae:4f6a:d2e6 with SMTP id d9443c01a7336-2aeae7d3e09mr15176785ad.20.1773211813717;
        Tue, 10 Mar 2026 23:50:13 -0700 (PDT)
X-Received: by 2002:a17:903:2ace:b0:2ae:4f6a:d2e6 with SMTP id d9443c01a7336-2aeae7d3e09mr15176495ad.20.1773211813084;
        Tue, 10 Mar 2026 23:50:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222e2fsm16505615ad.2.2026.03.10.23.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:50:12 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:20:05 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND v8 1/2] firmware: qcom: scm: Register gunyah
 watchdog device
Message-ID: <20260311065005.wklyszysmikqzv2z@hu-mojha-hyd.qualcomm.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
 <20260311-gunyah_watchdog-v8-1-4c1c0689de22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-gunyah_watchdog-v8-1-4c1c0689de22@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: MQ8eBnnBV2C9pCcA8Eh5gX1TyVol1xUV
X-Proofpoint-GUID: MQ8eBnnBV2C9pCcA8Eh5gX1TyVol1xUV
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b110a6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=9y8fv63QlTsTVFCdDt0A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX9UA+gDYBwXym
 YpoW36nIkjNnA41AB8L6qDoT3biraEkVbxzKPAL2bGb86XP83HuxwjDrUXS6YN64J218NChPcai
 GQ9l6LfDucsPDKJ/1RRxG4bVna0PP1cAlod3AcWmcRhzWDvB55JBhTXijJFjFt2DYrSRWVAMx7P
 yvDMvlp91+Hsc7unAKMfXJga7CFjKwFmCYYXUqeTiSlEZHMpTazkRe7dxMppPMsqZNw+c7iz5bO
 DKTeuYuMRpmvlWVNTFn+SgtGsdy6S9RiBPHEFh7eEkwKR6vCk2OXE5Wzoddl8lG2rZspeRJ/2DX
 zSxMcndb+AFEwYs72lRNL/UedZXU2O/O9hZNcR08k5wY8P2gGbTNzMJifAZKbuLRnourK9Qs76S
 R3mvk7f+2Nz9rkgh7eAQYNnxY0bVIfmN8TRz1HWYvD7B4YO863pxshpQ/G/VE+G3W3So4reasgo
 b1fx8hpWIgVAMxF91kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056

On Wed, Mar 11, 2026 at 11:16:30AM +0530, Pavankumar Kondeti wrote:
> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> 
> To restrict Gunyah watchdog initialization to Qualcomm platforms running
> under the Gunyah Hypervisor, register the watchdog device in the QCOM
> SCM driver.
> 
> When Gunyah is not present or Gunyah emulates MMIO-based watchdog, we
> expect Qualcomm watchdog or ARM SBSA watchdog device to be present in
> the devicetree. First, we make sure we're running under the Gunyah
> Hypervisor. Then we move to check if any of the above mentioned
> watchdog device nodes are present, if not then we proceed to register
> the SMC-based Gunyah watchdog device.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Tested-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>

Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

-- 
-Mukesh Ojha
