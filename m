Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822023;
	b=xmatUKv4wLx/LVnLYCubJ6DK0oLIEE9kziCZjU7ZKIkKt0VMc3yEeviF0PUMKjcNGlxB
	 JxGLSwGHmmuUYaGiyn/GU0L9cyeV1sNGLIfuEUOKkcBMu/6RJynYOL+iqUI9zYXgWlm9m
	 uYbWfPUvDVNgSwgoC2UuZr/mVNqCgiJ+IgRn8NTgp2rQHQe6G3+/LbKRJ133/sb67qp18
	 9AMk6hc980JvFHMaazgZnm5BXoWVhnIwziAubdouaJzanMA/KsTuH6bkuYJex3+a1HTkf
	 QOagOnVeeOaV0/Js8Us05kXCkJr+ZeHwsh4m8fuwm4nJ7LelbMx0Kdh7+V9ksn4g+ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
	b=U1kQ84oapu6s2LmpU2Km9R6IIUpq1WlDb+R7Y+BHCi3FviGKYXcxVtJS58mLfVTIXfen
	 wx/HUmgRjCEAwMaf1NAjeOYZfsiSpfBWAqnhQX1z3wpbFDSX3uvovjDPCkXH4wQYj86h9
	 6I9L30IB/h8/quuoIYD3Q0bJZMCUDoDoOFoGIw8Rb0k7CU+O7qCbiz5Nlw8tn8OPPo6Yx
	 fE6dtY05IwhO05YQMPTKx1S4sfnsgi0Jr3w4Cy80xwe4X5wdiAV+Zh8NsyVP/zQCZFFeu
	 sXapCpz9eDgMMkyIrQwEWTsKcWteqWXqqKScyLuf4UleK3CA2C8Fq0fOOFVUQRk2dUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B5609765C
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C62B5609765C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=snwKVTUy
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-19305bcb72cso1062196c88.1
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Nov 2026 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822017; x=1794426817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=snwKVTUy9LvBIeZYEhCXzEnRQp2wodIFGKY4wUJ7ztWzLVbTd1bI4nr3mGXqrQXFPO
         83/HtfEisb8NH+6TKxRanc+LHldo4EqJ43kuJQJyWdqbEb2qaKJ6REpFD/Jt5EslTB+S
         zscnal0Mvh+NX91kiP+siOH9v7tqEITC6j8TarPFAWvrj5zWcfX48CLTn8neQnUjk0aG
         DdWT6beozrR7hgNmLfQYYUBVHi+K7i2h0gb1c9TLmiQO015gt7sDVMBLhaHB5Rgu8J3E
         vDvOsMZkyxTj1DF9F5rnA3mHVh2Jx0j8rAylzbJGVo40aem9854GCIhJgMsA/lSZgxl8
         K73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822017; x=1794426817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j77TQJheY9BNkuAUNT0wTTk7+HF7XEvTQj5keMW7u/I=;
        b=M8hrg42KX1Keolyk5bZi7399JtEEwpEsn2coHMYmPJKHSwlUXtJuctGdKMRAPqvnwd
         zUgoYwD6GDZSNlwP3z6Obem7pxP4PnTBI0G6y3aiUzi/DOUha96K7KpuekxeiP1tdPxq
         aUYvyni2g6sOqAcEJZhNyEA5SpaujNA7KLxNXk2UkwXYyXl7O+lcb7U0AAvO1vpqiSRF
         qjWiqM6xcZepvzrSRkx/fzuLW9ERbAPP6ByyCBCvDw2aFLg/5eLNWciFSGkAC3zrm3mG
         E741KtfezdiNjU24s8lTRlW2MtXwZTIpOmqsaom+21ADI1mICdb749rvKPgGVCnzuVoP
         rUkA==
X-Forwarded-Encrypted: i=1; AKwUvBxrz6G/tdhedw/Ed5fQKtu0zrNBfLVWSY5u3wBugvxjeoq6LosFKEmBp/Fhgexs40niJEjZ5qevXRRtrhiYXw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vWgehL7UcAzDpRWsgiqcMZAYZUavulkWu6hk8rHuIYlPXS7nF
	V5xodjTjdfOCHiR0BChw/Lq4UJs3/LGpNcRUXUYCHZbl7s4UbryVLLY=
X-Gm-Gg: AYBFou2LCoUrlk6hJk8FUAVrJsiCK4WU4hLQ8vpK2ySbebvszu5D1CQxutCaHxuMHGa
	PexvQIqX4atCbRlIUyckEZ/YjW1psId2g7w2cs1cWuGAaBRfjeEJ5H0NUkiJDIc5igYMt/WIqud
	+V5LA0t6HcA10pckT4j+pOoClEM4OfAo1TZkv1PNm50pN2sC2TFFwQhapocUXdsUbUnWCjDju2c
	gHNw0fA6D0/pueaRchrWfOwGbx9tt1yP0Rjk5gZ2czMq0ngCAZ2YURwZtCF3PpNrOPBYPAkArYS
	dQGQMJ+fKhSoteQggIR/ysgJYZsafeFsB4I3JL1j9+CYP/JKUIUNNospZwoQy9C0KVrbnbqXAf5
	g7w4xGUPs6mWAkK3eE+9dVChkrEcOwWfrSYjGmRZcLCIe2OAABk0pe/BUCQ/Tk0zCfNrec+Y/uz
	LEBStwqE/DjDdNEj7YZvsJiIdre9d+0qKEyAG32BivTOQSofgQT147LtSQkT5PSGu5sqR7whNQn
	KsjD8IqQHCyLC/1cyXDB3kOP+bAEXlN6sQW8XZ+tKLeLJzMyVzXvIBXcxmx6Cji0lbaSvXNeIx8
	JnaaIp5N3S26epuzdFAMJ0wRl3R7Tx/nCPVlc99tEMtbTt2DNoSk7h/tnx9XsB52
X-Received: by 2002:a05:701b:4241:20b0:143:2968:564c with SMTP id a92af1059eb24-1ac5b9cb040mr26455364c88.26.1793822016817;
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c2d69asm9239684c88.11.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:36 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
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
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
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
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Wed,  4 Nov 2026 14:53:17 -0500
Message-ID: <20261104195317.8284-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101013817.22d67ea7@jic23-hlaptop>
References: <20261101013817.22d67ea7@jic23-hlaptop>
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

> If this isn't matching some legacy interface, then we need more
> on what these do.  Maybe they are suited to some other kernel
> interface? In particular they might need the various controls
> on how destructive they are that something like fwctl brings.
> 
> Generally an arbitrary opaque path to firmware isn't a good idea...
> 
> Jonathan

Here its required, if we write CPU/GPU Pstates and PPT to
some keys (MSTS MSPC HE0N), we can reduce the temp by 10C
And We can fix the dreaded PROCHOT signals on macs, Giving
Same temps as macOS.

But you and Sasha are right, that exposing all keys is a
bad idea, so i have restricted writing to some keys only.
