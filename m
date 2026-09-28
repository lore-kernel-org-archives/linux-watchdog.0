Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDC49B470
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637866; cv=none; b=iajO4x9HanEyw1JX2V1aAgeRgD+7W6XNpiVtDrIqRWlxFJKlBY+I+UYRRdx7rW8eQ/hT9nzUjiijYau9d8JjLq9I3gZbXIVSA6e5h17rW3c877fk1lXDxU6PC8gGyI5FZmoBGzmy5h46IGXDfhDZSomi/v2CSVlOk1OMsxd9+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637866; c=relaxed/simple;
	bh=HZ9EcX1lkWL+XWXcKS3X3cZj0rqlvavRCndufxDRODU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+5z/YonL6bi99rB5onfcmIwD81b3HKkBw0AlKOg3MdWjZ/O7TtfLi0PCLNgegGIs65cQSjNSVbl8I0++5j5HaEDUJKElaA6fm0oHzaKlXsaOmsIHdwF6sg2JivQhIaCW9e5ZkalwOQM9Ls8cQUun3vcfqDve+qJn/XP+DBFGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTQDzq6I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i844Gn5p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTQDzq6I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i844Gn5p"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLTNVW1927973
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 23:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XoyLUTFu/l3yoOpGw3lzvm9M
	jMkR2yyprPZj7j8euak=; b=cTQDzq6I4HSX4ZlHAeNmAhCMCdOj/sWlmJ7m1FL9
	eNWTMYNT15kB3c6fyTFITtUVfYylaXv3/vwHJ0s5izVAAfvlFCxeqvkUKscJ+B5M
	Nv3FWa9hd+hTqwhfOB1OZewjA78nzZUc8z21ljPsIOLAmfP5qZ2pW8NJjcDENs7w
	QaHSWzQvPF36T418WLedYkct63UBEk6VGSy3QGfz7dVujvQ1xH3ZcM/KMbmy2kOr
	zRrucUvqJF+g157DuiopDTpV13bZjL6GEsPu1s5MNihFFkc+26HBkZ/UJZgS99Lo
	Z8ZKBhcT0qdh0H21Sa/B0b5pbRXXH18n8PCQCJtWBrjfYA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw217g9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 23:24:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34318e88ba2so2006607eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 28 Sep 2026 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790637862; x=1791242662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoyLUTFu/l3yoOpGw3lzvm9MjMkR2yyprPZj7j8euak=;
        b=i844Gn5pbMyiOgKmIHQQU3kvFX3GeXV/1IBFVPAaw9IzidyTW3ath+m4gTUBsbkLR+
         pkgaqUMvBjBCDWBW6/N43hMHviASPk48KBb/64vqB7a2DnqYq3YomeHbeuFc2wA8QpwA
         Spbl5rHPO40M7AfzvHrVmlokxi4cym9HF92g4qLSqt3x73V2yXt59NwBg/KGJFlEdH1n
         OxAhTVTFjqO/QlqsEp1T8K1cnz8R8yNb+ylAqNxzTI8bo+hNHz6W1gykEqPzBEH4opQ1
         qDP/3dGS/a7jFP78E2ovRXjJZvEErIj88yYLrWO3peXQ77+/BQwP+Wbc5EGgqxhpse/l
         qGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790637862; x=1791242662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoyLUTFu/l3yoOpGw3lzvm9MjMkR2yyprPZj7j8euak=;
        b=LB6UzmITho7Q5itLVbz+EZj1myB+6udA/46mga/nfwIGxqQOWpHMKGqWUSQo7VUfpU
         zlozd5XHKoAi3JP265m2C2WhoG1xMCsfiDE25kIAJRUb+0GFtPzLR8ukSr5KnJqhiG0U
         9YM7ZcDRiMQGocS9udPAlBJd+RWUEpkh8JCls5nCKZj1yh54igOshWIrnyZfliB8MkXG
         4c8Bf2O2/XvkeS2h3qL6o8p++pjxVuwp7YOPN4Qb2fcAd+YLq0/fBoPlJ8R/f3hsvMl5
         FTQsnFOhCrGTjlriLleKaZm4U87+mIz0hQIRtVNyOCcWHsvKwSjCOm9y1zqpWzID6x0p
         JQbA==
X-Forwarded-Encrypted: i=1; AKwUvBxFOGqtuHTJ4xWyaetRSP0IVx63r9D0g0XRwp4pCZcBxALX4t2Ms0HdxPXRPB/vCDJTrNsnmSkHSmAjQmID5w==@vger.kernel.org
X-Gm-Message-State: AFuF++nXc/tgtiDJhUUCPSfzDHT+Bgvz1wnvGef+YVnNxSuzMXlsG5Bv
	IblOSbJYSpYKgpbzdu9l6U4xEEO9pGBZNCz8b5okA13JApaFD68IA78aue0kAQQadvFgeQklhKX
	nIivirKi/tgtqBpHtry8fZYTv0+cHy+rv7XXF1jhtGUDd0u0qJBjHjur8JsmERejjSQxpuQ==
X-Gm-Gg: AYBFou1yI+H5CjtVVn5MNsZPuzN2tYG9bgtbceerTO9Yu918lUy0JEjQqgsnDpPfl6H
	oogbrtnyukdiPIAV9/yft4e1LDSQDaXHvjv73ynry7ZvIahyb4m71w/U0OdZzTUMnE88vDrJfXI
	0WkONgI+AwyZGHGcX/j59cqIgtU2vHthVTOlBvwX8FBY/Yan8GSOHhgPHgiBGu2CiYe2Z6ks7hz
	Xj0PoZSljTJQV0IaitoxFAs8ficQpcwhU12IksQVEyiCqFNvmY4TR/9Yz14nDH38c6QC4ZyiEBT
	9M8oKzbcFQVaqvDYiK+XnCOTQb+E18hI6Y8XjbdGN15tyGURMElxCAMR1xv5KibVeOsfHR9W8Df
	Po7HwFcjmgDlSMdjj/je4RmW+WvHnJrz3guYkNh/bPmJ0dKtb
X-Received: by 2002:a05:7300:a987:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34271a8dd5emr14957229eec.21.1790637861579;
        Mon, 28 Sep 2026 16:24:21 -0700 (PDT)
X-Received: by 2002:a05:7300:a987:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34271a8dd5emr14957189eec.21.1790637860989;
        Mon, 28 Sep 2026 16:24:20 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341459234a1sm30024130eec.24.2026.09.28.16.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:24:20 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:24:18 -0700
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
Message-ID: <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abaf727 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=MiKnSkdogZtXdNbqYk4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: jdKOvcR3mN8MgeMr-prl1WhLFTLvJ9I2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfX3n23WR4J4KgX
 Z6ZzMkB0le3lGjqtGcM/dMW1Yx1ZCMnhHbcUj2dEiSmLA5M5V9H7fGGwhvLY7DI0HFigpOVuKmW
 R4OV6n3QHIwHBiRSFQ+H6O79zSRAK0B06ytseiyoSkjVfDn88xYaGa+UgfoPTysIgVUZieFFda0
 cbIGroGXp26OZXro5oVPrdZct07nW6qM+VdP7TReEkH4K14TNClVv/4kC/MFo8mc7chtR7BGAqd
 f+0HE+HcC9v/qPe6C/s/lriOtV47yZD/bjBKSPrAfDhZ3siXYNVc1mHjKU924AL/RbtMW+pvP9d
 qb3aEMeUwUAm3emBvZdDHc6A+WCJ5A2LHyAWEubkUUur845N2LTXrvOqONNV3PEHXXR6uY249PJ
 fwlUVMpznWEsOLd/jFGGjX2KqOJ63tFu8PLzx1A6oMWj6hYxOB4pu2yxa7CkwqhTyLXUfXI8NZI
 sit0uIa6MELpSyNkUyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA5MyBTYWx0ZWRfXzNtMUyk7Ah9T
 MUEtDojHrQxvBsi7H7JYh7qYcmyahM+WsfHp+7DiZQpxPRLzRekcf4TpBDu+zHqqq44AV0Od6YF
 MLJm4YxuV/jI1l8go46MFsbDyeTnQ+A=
X-Proofpoint-GUID: jdKOvcR3mN8MgeMr-prl1WhLFTLvJ9I2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280093


On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> To describe and map GSIs for firmware nodes created out of ACPI static
> table entries in a uniform way it is required to define some standard
> properties and attach them to ACPI static fwnode as secondary nodes.
> 
> Define properties names to describe GSIs and their trigger-mode/polarity,
> and implement an irq_get() callback for static fwnodes so that core code
> can retrieve and map IRQs for ACPI static fwnodes in standard manner.
> 
> An empty stub for property_read_string_array() is also added, so that
> the fwnode_irq_get_byname() interface falls back (through
> fwnode_property_read_string_array()) to the secondary
> fwnode to grab the "interrupt-names" property.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/acpi/property.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi.h    |  4 +++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8ee5a1f0eb48..c609100c08db 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1766,7 +1766,74 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
>  
>  DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
>  DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
> -const struct fwnode_operations acpi_static_fwnode_ops;
> +
> +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> +						  const char *propname,
> +						  unsigned int index, u32 *value)
> +{
> +	u32 *values;
> +	int ret, count;
> +
> +	count = fwnode_property_count_u32(fwnode, propname);
> +	if (count < 0)
> +		return count;
> +
> +	if (index >= count)
> +		return -ENOENT;
> +
> +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> +	if (!values)
> +		return -ENOMEM;
> +
> +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> +	if (!ret)
> +		*value = values[index];
> +

You lookup with a propname, and then qualify with and index? is it
possible to have the different index but same propname? 

Alternately you can send the list to caller and they can use the ones
they need?


> +	kfree(values);
> +	return ret;
> +}
> +
> +static int acpi_static_fwnode_read_string_array(const struct fwnode_handle *fwnode,
> +						const char *propname,
> +						const char **val, size_t nval)
> +{
> +	/* Route string handling to secondary software nodes */
> +	return -EINVAL;
> +}
> +
> +static int acpi_static_fwnode_irq_get(const struct fwnode_handle *fwnode,
> +				      unsigned int index)
> +{
> +	u32 gsi, trigger, polarity;
> +	int ret;
> +
> +	if (!fwnode->secondary)
> +		return -ENODEV;
> +
> +	fwnode = fwnode->secondary;
> +
> +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI,
> +						index, &gsi);
> +	if (ret)
> +		return ret == -ENOENT ? -ENXIO : ret;
> +
> +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_TRIGGER,
> +						index, &trigger);
> +	if (ret)
> +		return ret == -ENOENT ? -ENXIO : ret;
> +
> +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_POLARITY,
> +						index, &polarity);
> +	if (ret)
> +		return ret == -ENOENT ? -ENXIO : ret;

Consolidate return to one place? 


-- 
/ashok.raj
ashok.raj@oss.qualcomm.com
Qualcomm Inc
