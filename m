Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A549B21F
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635293; cv=none; b=VpPJokZwseY7mFfF5kBjciAXlrF0H8SVNh0xJBfs1cD8QOGpx/XkFPh4BclwnnxCmDa+7nPQCWUhkcsZ4ktuTKucZ1zf08mvBi0Srul+v37YRQySSpsRKApdCh7KMs5ivtW/Gt6A28UeRgq/Mt/q1lcsujCRVMO2kpYZpDn3kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635293; c=relaxed/simple;
	bh=dlibW/vQ+f9/VdkDSXY1CFVI/jcz3sV6AIMdfgpLZ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEHyr6wrgkK+Da2C/TVxO+40Zp/jgfNqj6XSIBzAOXoZCFYrQQgH3Y3ETyVp727E0di4CJ662OdarVFX15oBxWCqDGNbzb2eimn0ItjP/gWJUAsOI8njGPab8HDUj4frhJTpkbAMSfv8pWtzdkIlTKIJGL9eqAPei5WXf+vB1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fjfMX7DC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOAZbSrU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjfMX7DC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOAZbSrU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTXXL1282865
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 22:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2LbniYZ7fnuS8HEmKzDH2uTF
	6sC0/heSzXV6COCGwWA=; b=fjfMX7DCgOmRzT/SXFHOJcxZhAEzsF0iR1PEIrfP
	2PdEa/zcK13cRf9T1vNbL0Dg8hnERdJYitVwMvmb37m9I0krzX/UukT9vhI69UR6
	lqjvxKl7o0WKuEzRtia83YRly66FDBtlLzXVBaGcIArK15GzkI4+V7Jo3qKnHnNB
	WWUDb7rAFiT8n24DIErCVv0m+IweYpsJ+XJts7I5Bkj7v6LNsP5UPChyMg5YTwnl
	17gWs35BJN0fTOILqfqy4rlkyEq34pwWHwWd1yeiQZdc2JeUqsGdNEtYpt5jJydc
	cMqZhq9/NSp4oyuHDnXG5V7xrXjmrPUkuhFGqdQp+AYaAw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyqx3ajhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 22:41:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34316295d86so5713672eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790635290; x=1791240090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LbniYZ7fnuS8HEmKzDH2uTF6sC0/heSzXV6COCGwWA=;
        b=cOAZbSrUEy6ew/rqHEbmzsgU+NrxQIu7Fj7eIgZClMQ/Ts1buuTxGK95mFycOHD4nf
         y0LYftWpo8SBvIVD9XimZysPhDlR284xUP2h2SEbvdldmw0qhJAhFG8PI+qnO7UMmu8x
         IFo99494ELx+hXVpXDRE3c+mcuBp0hGUbja/+DOwIpI1Nn74QQIcC0b3ACR9u6XzOfM9
         CATr5zZHscKlEuwb3cfMQ+lG6Ui86rXxcvarJ1jdtFFt4Xt8Jcf+8gTxDzBqp2HNhxct
         2Xj3rWAA+f4A1CX+qrrEK1pqu20Hd4RXgikIe1bGaeZxRmci9cg+JgWJ6p59S0SumANh
         +GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635290; x=1791240090;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LbniYZ7fnuS8HEmKzDH2uTF6sC0/heSzXV6COCGwWA=;
        b=ADcVzQp4iZmUI7FiBdJeMTEnFVz2Sz6CauFSWds1baSkvibbJddgfZ5rcJmqPM97fV
         fblFCai3SAT9fMAG/KDjuqFff8bJNCR+m6mRrZjeAT6mmYiInwNJGjBgJ2I0ZxpvQNLT
         AVsH8sSDRNeuSQZM4XCx/edwzE9zScVgKTRNwqWyQEEFTCYn9U4KX7Xe1RW7Ng9/oeqZ
         /Jv3cdns0epO5jOBb8rSlSnjAuPy7PFAFV53ZtyIhRve4HbZ8PZpBHPPF5GoVJbmWhb6
         r4uIzNYkK3RvU8TrRjprPN3mVq4FmOI49bbuL1XxvdtemxMH5JtHsj/QdafRmrBsmUEa
         WPag==
X-Forwarded-Encrypted: i=1; AKwUvBwKcXo4ZZxJxUgfVXZ1R+XXtnBnh9zmDHFY7SBpWKulvhi4PJ3KwXGwqLutUFvhv2T8k6IuOCinavBEl1TaSQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIbfPi0lxhEedx5Y+gTMWLi+QEFDRz3aIIVOJvmunePlinmX7Ff
	Tmq276zz/5CErm0/0d79vkLQWLRdlv3RDcRYejMbBb2y+Q2A+eumtJoz6pjRpbnCtT+G4qtNrOZ
	THMOiKsSm/RbIbzFVMwMBWOFpEHeXHEXDn/V4o7j2id/6NDiSwCZp9cxvmzN1tTxdoB4G1g==
X-Gm-Gg: AYBFou0vq6yZaKdepAIAD9tgjkKlcEacsBBHKsNqC5f7NxB5Y2usk2nR1IeEZZLW6QC
	SI/SDcRQCu7kKtlEmRw/SNNVAG8aBI6BVQVzzSBXBuMEc8OWymwa6MvqyhzywDjnlOs70WQTHYl
	Gk7UsqtKNrIF/l7g66mL9XpKfK/VAiYV+UaYuyBB36l6SnySaLzcfKApqp5C3ZBwXxqamhYVZcH
	QTdm4CMiGAsIDk7gIFrh1+vEXz62VzgtUhQGvo8hapji9ODXkkoXFTlzKTUyITYiLEZJ46cXI7g
	R+MBeUgb44HsByryYBEvsDqOt7msLNE80nL6m4ihMZixEUDhuuxhAYf6Qmb96kedy+h8NvjtdVi
	4w5pwbbigT+CqOHDReumvDNIZqxAE/8vaSsI4paIH6Zd6wEo+
X-Received: by 2002:a05:7301:428a:b0:344:bf6:cd8f with SMTP id 5a478bee46e88-3440bf6d66amr7350724eec.31.1790635288883;
        Mon, 28 Sep 2026 15:41:28 -0700 (PDT)
X-Received: by 2002:a05:7301:428a:b0:344:bf6:cd8f with SMTP id 5a478bee46e88-3440bf6d66amr7350648eec.31.1790635287162;
        Mon, 28 Sep 2026 15:41:27 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a49febsm32699771eec.2.2026.09.28.15.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 15:41:26 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:41:24 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH RFC 10/11] iommu/arm-smmu-v3: Add IRQ mapping
 -EPROBE_DEFER handling
Message-ID: <arrtFFtK7KgQfr0z@hu-ashoraj-lv.qualcomm.com>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfX5kBvYepQtjBJ
 Ygyz1ucWc6xmlcNFcZb23Fie13QFsta1pC+YkGR10VTqEclMAJwGr4Sj/LyMQDS2Y3iWacIAw6T
 G0dL01jVTOdTAbJotFCetvyz95KQspO/HsnehS+2CmPjljWSPDPjyFUDeCbVREypL5jYxi9rfeu
 aTdDOOVhrIbwhHThhEdhaG+PSy2fkG2pntNreMtaZ8DqCvvZh4cwzd0evCOqRiCuLpgC1jK7NI4
 6vdkukf3hVXGRd5ow4fHkMdOC2wArh0K+QJLUbWkzdH0gUO+vhJaYuEi/Dgm2EOWe4Ts8ovSazA
 7q13n/zdB1Sb+cl80NICL7SnEHSsCRGBnZ7Ftu16MUtF3RlLS34tJIUB42ymRwkgOgbel2T9Af0
 99XM7Sq3+Ejb8BgBieMD9CvjSoD7bJ3l+akyXk5Z0e71fpaFfhOswIzAd9p8iFsBr+/U3vf2Tzc
 WHpp8Vcw98qPoVV/eaA==
X-Authority-Analysis: v=2.4 cv=f7jdl+yM c=1 sm=1 tr=0 ts=6abaed1a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=ZUgflM6HN2uMUVLQTkcA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: -ys6y0WJ68-iRrfiiRM6OCKsM2orm2pt
X-Proofpoint-GUID: -ys6y0WJ68-iRrfiiRM6OCKsM2orm2pt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MCBTYWx0ZWRfXws8l7/d7GORL
 D5FqO0Vx3pdodnnJHuER/1DV+wU8jFgEVBtScaz068dPICmvaEdBQOgD/7K/eVp7QgBtMJiGuUC
 o+orG3cfgKotiooAMHiXJDYite3XwzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280090

On Fri, Sep 25, 2026 at 09:48:09AM +0200, Lorenzo Pieralisi wrote:
> With the advent of GICv5, IRQs mapping can fail if the interrupt
> controller the wired SMMU interrupts are routed to has not probed
> yet when the SMMU driver probes.
> 
> Handle -EPROBE_DEFER gracefully for IRQ mappings failures.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122..1832389916a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5562,18 +5562,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Interrupt lines */
>  
>  	irq = platform_get_irq_byname_optional(pdev, "combined");
> +	if (irq == -EPROBE_DEFER)
> +		return dev_err_probe(dev, irq, "failed to get combined IRQ\n");
>  	if (irq > 0)
>  		smmu->combined_irq = irq;
>  	else {
>  		irq = platform_get_irq_byname_optional(pdev, "eventq");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get eventq IRQ\n");
>  		if (irq > 0)
>  			smmu->evtq.q.irq = irq;
>  
>  		irq = platform_get_irq_byname_optional(pdev, "priq");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get priq IRQ\n");
>  		if (irq > 0)
>  			smmu->priq.q.irq = irq;
>  
>  		irq = platform_get_irq_byname_optional(pdev, "gerror");
> +		if (irq == -EPROBE_DEFER)
> +			return dev_err_probe(dev, irq, "failed to get gerror IRQ\n");
>  		if (irq > 0)
>  			smmu->gerr_irq = irq;
>  	}

minor: 

Maybe consolidate the multiple if (irq == -EPROBE_DEFER) parts and
consolidate the return to one place?


-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
