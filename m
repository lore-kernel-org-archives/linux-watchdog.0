Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287579;
	b=vGNToHSul0uF4t9Du+r/5gZKMAacgI2w9USK9xBRVGxNcPi442H6/hn7lNxThelVPo0m
	 0YoofyVljvTJGZvZNRuPnnBTcFMq9FGGw5N+s2ZV1DAwNVgLa0/W1rk8yx1PUu5fLSXcy
	 w9qcgX0ZT4mV3e2GWYis65J4po0HsZIb+Y/xwIOOmc+Geyv2xCUXnCtq27WilomrOdUhh
	 fwwka9GTxybAUpgdmgH+acM42XoV3DW9Sp7A7YqTHXkJsgdoGKI4AtZWv/XTsERBkaIdQ
	 ogbiBH5WqdcXdwOvEAKdgBQXSksIEjZzBNBSOoDsVr4hsq+VDyG4bBTe5/OA93cdNtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mpW7Rx8PuBJeOKNX2dQ8d9XnAjnbB8743kHyv8YBQHw=;
	b=xPcofZKhrpCpfRAisJ1NgE7JkyodC2JWYX8SNtfl0aXcs+QunHq183Wb9VtBn7gO/lXI
	 oIS/jSk5ObNXPBScAEiJ/ym+jhfEqHBiI7/9EhigTX0LREk5dTZRaNE9MpZP2f5zJ9vNv
	 aRoIaM9QhXnaD8ZETOn11Rd9uiKPuweMbGU6vx0Es7NrqEGB723aTTfmV4wZb/LbAlTRV
	 vsRualxbyKjm2Bo49pydJg5JBDKnF3m9wED36Sq6F1LF+yB84UoRkbB0l1ZTlRAKIK/H8
	 vIxtNebaddlQp51J0EpBdXrt3q3SQEp17SqMt8l2+fRWUGll9+DvVYMUw02dMleZeow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="CFHq/4I7";
	arc=none smtp.remote-ip=95.215.58.218
Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB6606A320
	for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 15:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AB6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CFHq/4I7
X-Envelope-To: linux-watchdog@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vYqatMBexbASiH/pDoDg+soUpC7jr6OsHv3SiCXY0DQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793287570; v=1; x=1793892370;
 b=CFHq/4I7/Ryp9pDrYCokipvX9Q3IBM65pbtpLZ0ZnxwtpVp4/KZergKO2A6hs85u2EgK1XI4
 salYWiH7GwXrPHodZwh3cocV/ZBi2TKG3EyzBZ710vT60x7aM4qAx1NbVH12ki0e43SO8KIm1bB
 HywAW1I7jNTMsiGuMH2y4/qo=
X-Envelope-To: linux-watchdog@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7378328bbc0346d2;
	Thu, 29 Oct 2026 15:26:09 +0000
X-Mizu-Trace-ID: 7378328bbc0346d2
X-Migadu-Flow: FLOW_OUT
Message-ID: <12988c8e-95ad-4989-a6de-e02af3c9ef1b@linux.dev>
Date: Thu, 29 Oct 2026 20:55:53 +0530
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
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
To: Sasha Finkelstein <k@chaosmail.tech>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: alexandre.belloni@bootlin.com, andy@kernel.org, asahi@lists.linux.dev,
 bhelgaas@google.com, bp@alien8.de, brgl@kernel.org,
 dave.hansen@linux.intel.com, dlechner@baylibre.com,
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, griffin@kroah.com,
 hansg@kernel.org, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
 j@jannau.net, jarkko@kernel.org, jic23@kernel.org, jmorris@namei.org,
 lee@kernel.org, lenb@kernel.org, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux@roeck-us.net, mfd@lists.linux.dev,
 mingo@redhat.com, neal@gompa.dev, nuno.sa@analog.com, paul@paul-moore.com,
 pavel@kernel.org, platform-driver-x86@vger.kernel.org, rafael@kernel.org,
 roberto.sassu@huawei.com, serge@hallyn.com, sre@kernel.org, sven@kernel.org,
 tglx@kernel.org, wim@linux-watchdog.org, x86@kernel.org, zohar@linux.ibm.com
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
 <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
 <0683C803-C578-4C55-B893-BC03EBF9A9F1@chaosmail.tech>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <0683C803-C578-4C55-B893-BC03EBF9A9F1@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 8:23 PM, Sasha Finkelstein wrote:
> On Oct 29, 2026, at 15:39, Atharva Tiwari <atharvatiwarilinuxdev@gmail.com> wrote:
>> 1. The patch is required, atleast on intel macs, as without writing GPU and CPU
>> states to smc, the system gives PROCHOT signal under small load
>> , and heats up a lot.
> 
> In that case, why are you exposing a generic smc key interface instead
> of one that just does that? If you think that this data should be set
> from userspace - whitelist the set of keys that are needed.
> 

Whitelisting will create an endless cycle of upstreaming new keys. But 
considering T2 no longer is receiving updates, Asahi would be happy to 
send their keys they wish to be whitelisted right ;)>
>> 2. the smc dosent expose keys of nature that can physically damage the system
>> it only exposes power/volt data, and the most you can poke is reboot
>> keys and gpu/cpu p-states.
> 
> Are you willing to make that claim for every smc-equipped device, not
> just T2? Are you willing to make the same claim for future versions of
> smc firmware?

Fair enough. We can restrict it to T2 Macs, and Asahi can later adopt if 
useful?>
>> 3. If a person is randomly touching keys, Its their problem and not ours.
>>
>> 4. There are a lot of things that can mess the system way more and permanently
>> than smc (undervolting for example), but they are not safe guarded, why
>> should this be then?
> 
> I think it is inadvisable to leave a loaded footgun around and then
> blame the user for using it. As an "OS Vendor" you have a duty of care
> to your users.

It would say the "duty of care" argument is more of a philosophical 
thing than a technical argument here. Still, I respect that but there 
needs to be a balance between adding features and respecting the duty. 
It seems various vendors have different views in determining the 
balance. The above 2 arguments look like a good balance. What do you think?

