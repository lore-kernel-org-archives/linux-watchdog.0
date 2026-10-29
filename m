Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284789;
	b=SUOVZubXajPwVPcHIMmfV1Wx57IjdjgENCPjUxZIsugmsVMRtF+Ap1JKvgVWM6DhUgYq
	 KOOTFVaq4jj6VEg5ZsLyuA0ErQpP8ejJZDWMIESiA968TbdwV3OFmSwdlbgvbTY6v2FEX
	 vzxOJ/H8ZtBUSodcVMKvcTz+xAqMYFjgYtf97S1KI4CTuZBgsXAwsYNj5U2SnZiKUsmCZ
	 I0bQeeWjVUwuAPKhR2rlfA29sXHZb9z0y79QGOqpqq6YC6HiQaJd94bYn87jCRJjrf2qB
	 hw5SdgexijhCtnJGSOQZ2zlerssZCQrNzzVPdvk5sRVM/AecSBdqkTTBLmWyrS+z+Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
	b=IuoJhI4o/bVqg0z+5W265an99rhi9Q6swoCf4jrXdddjvpzJIo8M/3WSxWi9M5bWXCqu
	 UAyWWeZDzFvJotjkOe6bjHKtjLpIWljFMdi80+HUV8UxUPsUTYKqxUnus+/F7SdFllPKg
	 d5N9FNtWgHRJcMg6eVSIzEve5GNgdDsm6VdHBxktabXGHDtP1ZD0gKldzKdQEAll+hymN
	 REagUUpznv4qAol8cIX6XQkoMfDdCxPw5FL6aS5Gqm/klwUMVfBu0uIuSKvDXm6UffUJg
	 TjB7GyQACjb27o3F4egfBlIqewiOB9z6DPJPDbzh68vkPJ9/+HgRC+5Yuix51sTTQZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F0606A324
	for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3F0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1846bc43c28so2543464c88.0
        for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284788; x=1793889588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=fPTlg3YKi8LCEYl7MWaRXbl+fOsMT8EooFaEX/qteZRl8FsZt88RyX9Nz4rh62atDU
         N2mi9nkHHOJC4qFeiUXhTHbjbhHQHXOF+NhhfCQK6iUf4J/Q9ypFok7z2wgCKAPn6EjK
         xZ9kY5ZnP4n+8lX6/VsHr77Tn99+eesUK7yOJOQntEtEMQGRE1D1vlqqCLeQI7lI9/6d
         T6b6GWLz4O6TATQ+xATuCOZzKNxV75JOEocPZj36+KoGY18UuoHpbDZjja7BkGHZcM0B
         8XE+KTQjlqXnRe4OF7u9IeoFkO5y9EWni2EDctTAKHudHO9Rp8OhbT05Vxxf/IOtY+cj
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284788; x=1793889588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=0/0MfH0hODnKHHj+03UT8hN87DF8jfoH3a5KY9FwsHyl5XspkIpAX3jhu6NxTMAR4B
         r1baLv1OXXzYcRA8+XYSO1pTl9iq0Ex2QbzLHWPM9dMh+gZ/ZCu4Pp4K5Z28Tjnrm9FD
         pCua99NnQaXxNXzaG3ed2l0nFgcGYkc9cI+LTxVh8mU08OYIDLqlVdo2A+9d8pwjfLwk
         IkgP2I0nxj1omTxdtg9veBVYpLxSOexWqS4meBd3hrwsdoPARe/ui7H72D6yNxSnhAaz
         1RsZK1sq8wyD9Go1h3F7fzwQgr6vqWzoEANR8QVx3e9fJG0+Wu8JLL1Ve2BusXkXvIGf
         wtYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGCf0OSEod/6TvMOP90KwnBs8TodXrMOZywVgMGboy1RgfQC38yZRm3mNSjvbwlUzEauBWtg1puw4S1m7i8Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIMLhyFDNRPiLt97qPjfdEAy9dKAyyxf6NEMfSmwBM7Sitfy7m5
	89mIic365a+kbIwlByOq7H/kmGx97nld2bDzeg8PQ7orZNX+ngLqjq8=
X-Gm-Gg: AYBFou2aSv6ur9tzGo1YnNqBapR1/f7kndOJxhp//GkGKz8dznqiImVxIYtREiZ9K6U
	lnxpgc24kt4Q6m4v7oQ1t4NwCkICR3EmL+xT/Z+wenPdtFKl6uiCwTmDJBNZCAFjPc9p1z5aNcf
	flFrjsVUAvrGwoef4QjDbaYivjYIP4Q/pqFiTxBxhjsHVtmFfy+r4m9GpxUuNgFdJkqdYh5IrPG
	wTKPJsF/TwJK9q4PcuMixkIrlOOXVcHBffF2p7Q2VMmmX2m4eh7QD4eiCfjTjWJCYVO67f7p1fL
	R2gyS2iwCklIfSepsDKVL/QLpzdkREnowBrOrvFqauCSbqO1CNvCs10wI+rt4h8B2OW0SmY9dEE
	jTcbPewwILfUsJasUy0d8SKwMBIoWyAWllV42uiJ0+EXYeM9UEiIt21tQx1Cv8HXo44LE6kIBTI
	DthLAU5wVoY9aOrXIXMoD8/cAy9d9UEfif2vqfvlkAIYwyw6JFEg6lyplLrgmNSgzIpSDB0mSjo
	Pmp6DOplTberlJ60p0rW1kMEShdU37JCAPfVfQSsjtO6sRxB23KWQ8tK46ZqIRG5F1A2qBRWucX
	DryaDRo9Hibq42qAAXfh2y8Z/JtSlz8thSJjZxO42rBzWteRPXpgOORFcW2gSNZTODg=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr7393000c88.29.1793284788293;
        Thu, 29 Oct 2026 07:39:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15396439c88.4.2026.10.29.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:39:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: k@chaosmail.tech
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jic23@kernel.org,
	jmorris@namei.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 10:39:26 -0400
Message-ID: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This should either be dropped from the series, or be hidden behind a
> `melt_my_mac`-style module flag, or switched to a whitelist approach.
> We do not know what keys will be introduced in new smc firmware
> versions, and there are already keys that should not be randomly poked
> at.

1. The patch is required, atleast on intel macs, as without writing GPU and CPU
	states to smc, the system gives PROCHOT signal under small load
	, and heats up a lot.

2. the smc dosent expose keys of nature that can physically damage the system
	it only exposes power/volt data, and the most you can poke is reboot
	keys and gpu/cpu p-states.

3. If a person is randomly touching keys, Its their problem and not ours.

4. There are a lot of things that can mess the system way more and permanently
	than smc (undervolting for example), but they are not safe guarded, why
	should this be then?
