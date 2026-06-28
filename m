Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1A340419
	for <linux-watchdog@vger.kernel.org>; Sun, 28 Jun 2026 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684805; cv=none; b=mJsSC7fVFU/uRXaTjGg71Zbf/6iwoCGsaWU+oi9hxiCCt9+MaLvDMf9DT+s7dbhkTJ/djIO55Eh6LfsjAqbuzmstmDpwtoOFm9UGlx1ZALo7ODcOAgH/vQzVhV1n4MnCKCqMJf+drjVKm0k53qg7IVwPtTvk2zsEesQvfIc8tSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684805; c=relaxed/simple;
	bh=ozaBsu5/rrlxZT3SQgt8UpGfMmLsGXhI3ZWESyfFpUk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C6ld3Y0yrzz1/akvT003PuyRodMg7iXPuq2b3fI4KdYai8OICy4mdgT5F15kjxhtWxeBSvYXY9oR1PNRaM28h50EvYdc2OPYjIu7EFA/feXjR+St1oekahJa2C/0s/cOa+ULqus6Jts9Ryd9J/ECkxq8g0/3uksepthqpakzfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=wTtQoCbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQjUcD6R; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="wTtQoCbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQjUcD6R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EE5A1D000F4;
	Sun, 28 Jun 2026 18:13:23 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Sun, 28 Jun 2026 18:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782684803;
	 x=1782771203; bh=gUt+pb9IpwUlNB7Lw1zD/n57/TpTgrylENozfOnRNmw=; b=
	wTtQoCbbnwKQ+anX52amQaeaV3+eCkvsddMX78R65/frKM3AuXWH/tz3QVn3IfMO
	y7/hdZBUpR07Z3odZfX0uKiiXEM07LUyGNeGKjTAV/cNiD4OJmcIFbA5RAhgwdNq
	ve0Mei2Qcfuby6UcKIO6/aSPYL+IwhkbamUHMVy+RIuMsshiB0jrTp3Cr8t7/RfR
	2jHcYHYfYHN4WJECkrWd2pGmCZ2LoBfyD2xornrdgbAGhqjNlytmfmiGK3lvdxLx
	A1JCoAisnFOQ/YHCGRLxVXllk2DintKzf1mPZBWtvPkBTmw6rOanWlcj5NeA+QcV
	UUx7olj+79P9gstXI5aLYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782684803; x=
	1782771203; bh=gUt+pb9IpwUlNB7Lw1zD/n57/TpTgrylENozfOnRNmw=; b=Z
	QjUcD6R/J45y1rXsB5UEeH7utnciVaXuybcdJcMXJL4pvtgnE8htfTNa0BVJifIS
	fw7weEmzAxf5OXi1RZcmz1bgY00JahqA88z53a+3yvIOgU0pCvvXNg/XlHb0vRGX
	HUedeW3fosG54VTV9nvTGZbBXPosfH8CyC0qGuauSslU+QofiYpPrMoCTZErdXPJ
	DzpfR/RRA1qrl4E7uws8P4jwidvsKPORxtYout5WvER0LGQxzQTYdsIWmhwMKvHy
	FTqQMoyfdfma5dda6o7X7EEJqXezfp8YNhW5Bp/82Q1FoVkcTYY1N+zY/jTPoVCQ
	pS9bkRH+y8yGWDSBCQE8g==
X-ME-Sender: <xms:g5xBapT5Y62rERuIHL3J10348adx7NvpSznMa-DM_gX2yVt0wlzerw>
    <xme:g5xBatkPy-2nk105L8STOn1Pn4qzNLufqsoeZDuAiamets2caVLyeU1aAKbQkvyh1
    6UtAeAx1Dfwae_OjY9jX655bLHz7PfIq9h7mJQrjU5m7AsnklbTw0E>
X-ME-Proxy-Cause: dmFkZTGb3NFbVFloWOueSolH6l5cBlbHmmLtM1Ms9o7oEYSibMCr1SXO+mhQ/siSExmxO0
    +ufwnIGmx2xhKyyWR/xa0aaLVdOQni+9keRxbF49QgUIVOp0cEq7zPNPHJ5LA5Jr2UW5l7
    LBt6E/zGsGLhSd2T+F93llAaF1TorgdAXbKT2qBOFmOtrVaQgr6O7DGYenHHCPbb2Rpf5z
    SxGmSSosspeeeaVW790hjGIa4r4TbKVItz032SyVK0nk2NG3yS9giCKhS4LhNfj2PRGr0a
    9Z4XTAZYpYXIUOwAlutcVolOYnsLIPB4EMIDx7PnOLKvOj6+uKNQS9kQMFmzT6nzqxtnMh
    sufBDBYfbGhsPXCsIyjze5oUgN1pghtuCE9cOQ5XjQWIvB559sFHm6SQ05e+T9J6GOsOOp
    kg3pae8mRnnmKqZSUVPsRjtmsDdSkiAbjPBDLtiZvQLFgA88VnQf23EWEJusRMEHJsSZ89
    M/mmiy8piu2hQOZfaFlnbiPHhJkgaOiX8oab3SGKHB1ZQBYybx1wmgMp4PJJ9leWu1sJNM
    a9raWUikUmDGt4WVbxfpVCEY0kbxobzerOLJRHNmR/BR99rFfs8pGcpzHNa3fkuaPbvUgR
    7Bd5zRbxiI3CgV/Nl2OF4l0rVQ03fpLcEwcv/zM2gCycqYxwyorCz8uVruLQ
X-ME-Proxy: <xmx:g5xBai1kN4EuWC6vF9R0gxc2VmHiopRFpFvP23SecOeOnczzba150g>
    <xmx:g5xBalOWozKuR6oK7DaGH-vRsSAoW8J9d3T55e4X4ZJfpDWV5kNe_A>
    <xmx:g5xBai2dDIUhy4eG3pZwrzx0vKx15qzXEYoH_gIHUlN9VdKeOi2nJA>
    <xmx:g5xBasEaQEorCmXNNe__RZDf2juLTk0u7y7UwQ5nu-xeYnZFQZnZZQ>
    <xmx:g5xBagIcRJcPGLXfIgVYRt7qmpNZ2-9iPVdeTi6d2kNzkvRQVwj2vIBA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06AA72CE409C; Sun, 28 Jun 2026 18:13:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArMcrDYeUHoR
Date: Sun, 28 Jun 2026 18:13:02 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>, sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Message-Id: <9860a408-cb2b-4ce4-88fe-8b65da720edd@app.fastmail.com>
In-Reply-To: <58920807-fbde-4a7e-b9bb-5a29be5ccced@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260625174328.3339996-1-mpearson-lenovo@squebb.ca>
 <20260625175235.49B101F000E9@smtp.kernel.org>
 <58920807-fbde-4a7e-b9bb-5a29be5ccced@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2
 and SE60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guenter,

On Sun, Jun 28, 2026, at 11:12 AM, Guenter Roeck wrote:
> On 6/25/26 10:52, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Incorrect error cleanup for a registered platform device leaves a zombified sysfs device.
>> --
>> 
>> commit 728400a02a11a5d2e004ae6d02e2731670483271
>> Author: Mark Pearson <mpearson-lenovo@squebb.ca>
>> 
>> watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
>> 
>> This commit adds the watchdog driver implementation for Lenovo SE30G2 and
>> SE60 platforms.
>> 
>>> diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
>>> --- /dev/null
>>> +++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
>> [ ... ]
>>> +static int se_30g2_60_create_device(const struct dmi_system_id *id)
>>> +{
>>> +	int err;
>>> +
>>> +	se_30g2_60_pdev = platform_device_alloc("lenovo-se30g2-se60-wdt", -1);
>>> +	if (!se_30g2_60_pdev)
>>> +		return -ENOMEM;
>>> +
>>> +	err = platform_device_add(se_30g2_60_pdev);
>>> +	if (err) {
>>> +		platform_device_put(se_30g2_60_pdev);
>>> +		se_30g2_60_pdev = NULL;
>>> +	}
>>> +
>>> +	return err;
>>> +}
>> [ ... ]
>>> +static int __init se_30g2_60_wdt_init(void)
>>> +{
>>> +	int err;
>>> +
>>> +	if (!dmi_check_system(se_30g2_60))
>>> +		return -ENODEV;
>>> +
>>> +	err = platform_driver_register(&se_30g2_60_wdt_driver);
>>> +	if (err && se_30g2_60_pdev) {
>>> +		platform_device_put(se_30g2_60_pdev);
>> 
>> [Severity: Medium]
>> Since the device was successfully added to the system bus via
>> platform_device_add() in the DMI callback earlier, will calling
>> platform_device_put() here just drop the allocation reference without
>> removing the device from the sysfs hierarchy?
>> 
>> Should this error path use platform_device_unregister() instead to avoid
>> leaving a zombie device on the bus that could cause collisions on a later
>> module load?
>> 
> I don't understand this code either. The parallel platform_device_put()
> on error in se_30g2_60_create_device() seems risky. Each of the Lenovo
> drivers uses a different mechanism to register the driver and the device.
> Why ? That just makes it more difficult to review the code.
>
> Guenter

Originally this was the same as the lenovo_se10 (I thought about combining them but it got messy do didn't). After review by sashiko pointed out the potential lack of free so I did this fix, but looks like this is wrong too. I need to go and revisit.
I'm sick right now (some sort of summer flu...it sucks) but I'll update it hopefully next week and do a new version.

On the differences between lenovo drivers - agreed. A lot of that is down to new issues being pointed out during the review of each driver as they are submitted. I'll happily bring them all up to the same base once I get this one right.

Mark
