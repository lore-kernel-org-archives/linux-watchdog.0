Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0865192
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728692; cv=none; b=mcqq4Zr0xnZt4hyRjpn3glHnHrKFxQGucHiSs5tWHAUc6hnwMdnxJftjLouoAXqfsFcKC4okhEMRgRcM/sIgRnsABkWdI5fs640fVMeBR3ZFTsKhBfmSa+rdjWg/Jll9q+dyuYp/sfPOic4SBueX6k4e/2cGdAAVcn+5ERLhqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728692; c=relaxed/simple;
	bh=lDQv8VNO6G/soX/VtU2MWJkebNPtrgeVeBYGPflNv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw0OPOoZhdEVUvtpy52C6IquxSE05xU7QGAYsGXbheHC7tP7cdeGSUUTKaTSooQB8qjwhUzUashAOi1DKSCFYzJkp7SwfibUZALT3VmIQYiKNYNwaCj/zm/Ar5LEEUNz49z1XEmeOSNUCMb7JqHCO3d3QN/+fYAhmHDdQJMAoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5CGJ63s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMgrflcf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5CGJ63s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMgrflcf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNQJd21046599
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 00:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DihlMyvHEyVrVer9hDXtw89b
	IAPj1z5S1SGkXU3ZFzU=; b=a5CGJ63sjO8ovHEMsXAudd/im6jBlkmBPClNu3/A
	3DUskr40A0eTyQkOcUh/Qvn2KJ/9P8JF2DOHpoySV5rmce3213gAGsfFPfYctJqN
	ck8RXSvaGxPSc88VpB/6g6v4xePBeD7hqrslAwaXG8HyW0f9kscfOK+fO3Cnp0il
	iw1LBbaH09sPHRJhBqkQWIIX2rV/IouRt0JHAew80kEHFeEhsRpPv8nl2MY2qJvB
	I2RYLgM8BJ4D7EFq+ryaNsHt/jzGuOEI3jmHote/9Wue4mVPlC8nD43zVNfm6c8M
	jFQW/g9La5zqpIVvFL2sP5Alm1lxkKdHgrSvXSL1xvI8Cg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0vbjj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 00:38:08 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so1342114c88.1
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790728688; x=1791333488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DihlMyvHEyVrVer9hDXtw89bIAPj1z5S1SGkXU3ZFzU=;
        b=DMgrflcfec/kN5X8OGPHdrFh50XcVsDLvtT22ZNdzMU5+UVUqlAuOPkZQM8zUNCsGm
         VNmQp7zbQGfn75u7oJTxbpfm36ESf7G0m51Ayrjmh5sBUU8BeJY3iv2ydi/BpU+ZmLYn
         fRzzygHfKTjA8FX0PN0FFhH/fFD+xcnMGLDLMV2CsoY5qvT2GARgsJjXfxUhl8IHtTug
         GQw1uMNHWIg4cbUYawd/M1eGpCY9Fw12rg3uq5KaLFYcs8pEvs8wQ7ZyS+/KJwyqkL/y
         2yx05OFEaCSc4tYMJM7MjPB4Bj5xEXMN7Go+NOMl9EOTRZsGDSmF4sq2lGBpRFe2SKgz
         mDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790728688; x=1791333488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DihlMyvHEyVrVer9hDXtw89bIAPj1z5S1SGkXU3ZFzU=;
        b=O/ViDXAtNcoZkmXKOedT3XUif6YH/pQyc7dL5J/xZrlskNs/XjQQ1Iot30RY0obKXf
         CrrzyXSpVyB1wKU0k5/jCoYXXSBw6EOkTFGyqR3eMz9byEtBclz6/dCH+wE1LMivLCEk
         5DLgxSuqfy0sfoZ/5figLds0y1X+RqKpGTxC1HMmWrT/+BKpinbeIzbcoOhhvj1aFaFt
         9pOoToCUN8b4B1QYkf5t7ck1QS2Hwx0vdF1BomSjO0nyP7dfEjDxsUHh+0uj3KE+W5lG
         llnUPu4Np2mfgINMugRMW8FyH5Hw7V9yvORyw6vOYvq1J6p74yIVFuD7B9zkCOEsZzTD
         lcrw==
X-Forwarded-Encrypted: i=1; AKwUvBxqNV0lGODOksb9BoOsY8258jT+IrOkKTybYUNKPXlFYp2ogyUOAO9bRYRuX8TEvXsWB2YFBUKqqAlvGANiaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ldVnErgF8xqKM1gVxTTKAMuTfaJv3hCff/knowpPihqSRUvgOZ
	AbzYq4jMXDKmVpsIgoaDqzloNiPDOs5E+SvRpKIs+6G982b/hjfiW4juM2fyEYQq3S51Oqsypbv
	L+T2fMKABFRz8pWiwxeRHgtNa5F7ym09QpoPldal1spLnZLnfoWQvBGrKBoHgZbu54aH7bg==
X-Gm-Gg: AYBFou2UNMuHst/A3GZVt8A4B22PB0uMLbkRf1VWmkkVDYYIkRTVRwNnsZXSplHOXhH
	mXxgwUXLRsYNkvkYIUhFVx3AjbR7ovjIQ/WnaK/IXDq+W/z5A6s+O8iLC8tZUbYwqLbnqsap7Pq
	5HM4Mvj+Y72Ky/rOTFKe0h0yU5Wtmiwj7wpyOImHo86lMG15fFYaMSwgJroOfiPP6ZGce8f9+U2
	UD81h6jhQPC6lkbIR7tnl0DK9YLb7WxSWxgn927x7+NTqlvZtO+dBNAEuzPWTANILGPxnNGPBUI
	EWdTVJPlwFRbnk3DsNrBHroKUQOeBt5E/C7UubzhN/qOEPSUdh0AK0vzpPlDJVbHh1d3e4qVqGE
	Hm6qD0O+3H+if0y2+T2IqZk2hnjPy8RAJjDEAATsv/TEC6IZM
X-Received: by 2002:a05:7022:f401:b0:143:868a:20c1 with SMTP id a92af1059eb24-14ca00a17c2mr1398036c88.46.1790728687702;
        Tue, 29 Sep 2026 17:38:07 -0700 (PDT)
X-Received: by 2002:a05:7022:f401:b0:143:868a:20c1 with SMTP id a92af1059eb24-14ca00a17c2mr1397989c88.46.1790728686996;
        Tue, 29 Sep 2026 17:38:06 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14c60c55d41sm1917754c88.1.2026.09.29.17.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:38:06 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:38:04 -0700
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
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <arxZ7BAya5ntRi6t@hu-ashoraj-lv.qualcomm.com>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>
 <art5m5QPXAOAvkvW@red-moon>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <art5m5QPXAOAvkvW@red-moon>
X-Proofpoint-ORIG-GUID: TQag88hG2d51dWKOSUiRyGMbYtTInWCI
X-Proofpoint-GUID: TQag88hG2d51dWKOSUiRyGMbYtTInWCI
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abc59f0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=p-kz3MFidYKym44KqwAA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwMSBTYWx0ZWRfXw57gpxtiD+i+
 jE/no/3CWlYpKpbQd+bPiflpeooUTwfKJywNZd8UJGpxyMbMC79342cNqDuoqc+IbiC53DjvqLZ
 rbUnC2Z+VVVeiYUA5GGJaDbIIAVC5T9fCxMmLuqjMfV0DKO71EHJKQq9dLxjpRQjexsn96jVGSr
 U3/KLNu5W+f6yRhhY0v/ntaPOmU6EVUTw4PFDvPR4jZMAk13YzkK2Okid+4IMYx+2M388YJiUzM
 MyeU03gXhoXiKcYFJv3YXPdO55KHAnuhMM1Q1Q/mvVjn5/hrZZcLoct8H1+vSPGFJKeX+gUOIou
 AUb6+p7AVhG5oD9EGRTr+hlaYzvk0pT/1KiPK1SWE1GPtr+C8LxD2kf+xYfXJ6rf7272TAQhQYc
 hBn6K7Fl/iRWw5+rJ6HiGjY7oo8MhBN4jftkZtENK/W9jPuzw/CVv83E9B7Cs0xF7MiIJZWElUN
 cX/Xj0nhieoythg1i1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwMSBTYWx0ZWRfX4/Pu91voM5+E
 Xlil1xB3Qy09kqZf9vVIy4f5wFmjTqkB8aSoK7j1Aicg7HXToxqpXl0+wn2gXCWkD1Yk4KlIAws
 oeM4Lz7EOBAFkVss6ZQPMSsPBvNF2H4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300001

On Tue, Sep 29, 2026 at 10:40:59AM +0200, Lorenzo Pieralisi wrote:
> On Mon, Sep 28, 2026 at 04:24:18PM -0700, Ashok Raj wrote:
> > 
> > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> > > To describe and map GSIs for firmware nodes created out of ACPI static
> > > table entries in a uniform way it is required to define some standard
> > > properties and attach them to ACPI static fwnode as secondary nodes.
> > > 
> > > Define properties names to describe GSIs and their trigger-mode/polarity,
> > > and implement an irq_get() callback for static fwnodes so that core code
> > > can retrieve and map IRQs for ACPI static fwnodes in standard manner.
> > > 
> > > An empty stub for property_read_string_array() is also added, so that
> > > the fwnode_irq_get_byname() interface falls back (through
> > > fwnode_property_read_string_array()) to the secondary
> > > fwnode to grab the "interrupt-names" property.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Bartosz Golaszewski <brgl@kernel.org>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > ---
> > >  drivers/acpi/property.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/acpi.h    |  4 +++
> > >  2 files changed, 72 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 8ee5a1f0eb48..c609100c08db 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1766,7 +1766,74 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
> > >  
> > >  DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
> > >  DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
> > > -const struct fwnode_operations acpi_static_fwnode_ops;
> > > +
> > > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > > +						  const char *propname,
> > > +						  unsigned int index, u32 *value)
> > > +{
> > > +	u32 *values;
> > > +	int ret, count;
> > > +
> > > +	count = fwnode_property_count_u32(fwnode, propname);
> > > +	if (count < 0)
> > > +		return count;
> > > +
> > > +	if (index >= count)
> > > +		return -ENOENT;
> > > +
> > > +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > +	if (!values)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > > +	if (!ret)
> > > +		*value = values[index];
> > > +
> > 
> > You lookup with a propname, and then qualify with and index? is it
> > possible to have the different index but same propname? 
> 
> What is the question :) ? It is to retrieve a property value at a specific
> index.

Gah... I'm wondering what was my question as well :-)

See below: acpi_static_fwnode_irq_get() calls this read_string_array() multiple
times from within the same function.. 

Sorry for the terse message, apologies.
> 
> > Alternately you can send the list to caller and they can use the ones
> > they need?
> > 
> > 
> > > +	kfree(values);
> > > +	return ret;
> > > +}
> > > +
> > > +static int acpi_static_fwnode_read_string_array(const struct fwnode_handle *fwnode,
> > > +						const char *propname,
> > > +						const char **val, size_t nval)
> > > +{
> > > +	/* Route string handling to secondary software nodes */
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int acpi_static_fwnode_irq_get(const struct fwnode_handle *fwnode,
> > > +				      unsigned int index)
> > > +{
> > > +	u32 gsi, trigger, polarity;
> > > +	int ret;
> > > +
> > > +	if (!fwnode->secondary)
> > > +		return -ENODEV;
> > > +
> > > +	fwnode = fwnode->secondary;
> > > +
> > > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI,
> > > +						index, &gsi);
> > > +	if (ret)
> > > +		return ret == -ENOENT ? -ENXIO : ret;
> > > +
> > > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_TRIGGER,
> > > +						index, &trigger);
> > > +	if (ret)
> > > +		return ret == -ENOENT ? -ENXIO : ret;
> > > +
> > > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_POLARITY,
> > > +						index, &polarity);

For each of the above calls for read_u32_prop_index() the allocation,
copy a value and does free it. 

Instead you could read the whole array, and just get each value and
discard it once? 

> > > +	if (ret)
> > > +		return ret == -ENOENT ? -ENXIO : ret;
> > 
> > Consolidate return to one place? 
> 
> Yes it can (and trigger and polarity can be just one property "flags", FWIW),
> if we agree that's what will do, which I doubt.
> 
> Thanks,
> Lorenzo

-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
