Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682361;
	b=Zbl2oi9+1fUqyagfMS1+k5G2zk23CH9QGSlDx7N6v+f/qpWL5jZtJTmVWmG3/LybED80
	 mlyVPp+fJpvnPRdWjM96eWhZPTYQrpLYteBV2Y3/xNS0oLf8IboisPsMyU6EaE+v8lUXr
	 IGLeYviYdUoDY4xNJh2WnSNGbEo3qd8WITEN74bzWQ/XzIUASz7W2VLHE0QAz8+6jRtyA
	 pzlX6f5iWb+FqTIptFlIw0piv5kGL/CNgSyYN5HC7jW7twcU+2JpCPpk2K+d3af8B3uEF
	 tbUsIoD8sjvmb4+hMLaobaeairOXRsEw9qpJNY0TxWnsyc5lP5APDD//drjrwQMAjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=zLZrkub1iNWGcsUrG6AoUeFQUZNpk/XAt3E+7j4A0WQ=;
	b=eXi45vrpv+cJ7BXeVI7edePIjmp2GwgMKLr84Zb0xq5oaL/A754eurosOg74B5lj0iIC
	 BCoL4LMrbF6JQi02R61mEMCtEW5yseGz4+JU8ONgAGN0YMCEEE0x/ZhyMSsw5XQdw1tnV
	 pRqsYqUQ10TEPNdFggwNHbcTX1roSf/fIEZtttSO4SqcSyCeVdmoGjDxin42G8DpWoAMn
	 blzc4p4LbzgKPrqnsqQLIlBMbnUT0BQ0GOhLumn4rpvKOmuVOldXz00e35OMMzWLc1+6l
	 dxnz590R3omtAbEvjHIbW3cdhlhDyIZrcsf6dDAd5F+0GdtzwYcFlDFJD0ihHT0FXpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arXtzPsQ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA8606A327
	for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 18:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFA8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arXtzPsQ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so17045265e9.2
        for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 10:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682360; x=1795287160; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLZrkub1iNWGcsUrG6AoUeFQUZNpk/XAt3E+7j4A0WQ=;
        b=arXtzPsQu1EPdBNkc+LZxUglq1R5SLX4eusig6pMw8mF+uodO9SP/GKWtCv5ee88ad
         qzLLCcncsbqzHbficciXETtEUoSXk0O3jDG734ziXNUUd5P0ir6y/+0vY0Nl4m1iiWWb
         1dfONHj65NKkeQp8SG7p60nJn+aIK7MovYXtz1yh+LYHkqEQaQmexlw0q27HKRB4M/VO
         JqfgKJ/BhA3rzkBzRm32PUe+whOxsvdHAakAnA82iaBOKwFzdE9xkAr/lL1pO2BYZygw
         ++FL9n5o5ZPEtM5bgyxvyLGDmdmkuVCDFQAzDXRJ2B4bv+9K5k4Ui1hPl/nMa+DItM8O
         06jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682360; x=1795287160;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLZrkub1iNWGcsUrG6AoUeFQUZNpk/XAt3E+7j4A0WQ=;
        b=y+lkoV2RDEARl35GoVKFq0mFILB1y68ehuJN/2obMptYENg8tIJ/Nxz1kvuvpSFOGP
         O1lHk2w51HkGHOLy883BnrrJSyX3vX6d+3K49fKxhPa16W1dbUXaJpdPf4D/odpLz+Ym
         vE1WRqPB8TsnyeV2mBg7SpnIcoZRwue+Z8sbb8Ujl4rOLGj1QzJYaRwjVVg5iVWqid+3
         ScOk337H5fhNKAOP4DPKT+ziaEkhwNidrSxRCi0iGlNfwwc+0qui/NNHe4GvCLmbPdI9
         abH2A4MafNprhqignUM4sKJ62awDO8HKCf4W8H0D++ayflP47BcSF/x2vqya7q6M1AfI
         QOcA==
X-Forwarded-Encrypted: i=1; AL+hErFSiQDfd9j2MN/oU+AnlDJ5knX43KisfU7muCGj6cM1eMT+PSNEyl/Tv4JxG1xWsFWyWTmC3N49Fy/1h+OOQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8eMiHnwPQNzIriPYOviGmeb3chkExbT80KtRl5jM4iou2AkZbn
	XCI1hjLkh3Gc88r7EpIYTCf+uIUlc8U8x+7ZDAxfHi9RzNPTIFUMkKQ5
X-Gm-Gg: AYBFou3jFO6p5Ndo+f9eUCNK+eEopw5UqJT4h9F0ZgatJjQERr/2BoknZIz5yHUChet
	/J8J6Q7MAlwtcd+lBVwZRzPapS6ummJOC8lYhGy8trwkMvpbIIvHiqdjw0AsnagQvJwZ8fIHmLp
	knP3Fhp32+kvXeI86+Wns8L9q7QkPSyJp0678fsagCI8yQ6X7m/81la5+9sBBcsuaORqOZctfmI
	bd1m1ypvw2bB72+Y5gYmVJNYHh/JQJlZ3h3US6pHtMGona51gkY9GGbxa9yXlpuZk8wWuwvh8AH
	B+lgJ72eAE2gG6pBTBjiCEgxmtKt4/KSCUlVhDE8a1DfZhMTL/ORHL6liN5nY4G6GjbMfa7Ll3Y
	MOq+l5I4bhUzD0zKwtW2SfwXM7Z1FDxGzepWnz0wjtKpQHydp+WaR4ewEfTL+PoHjg9kNzv/etd
	FcRWfT/++Yd4CbFBoy6bbxWao35VDlxTF5QnnlWaT3gXPrVvuJQwEsYq0CJP84kDspypXSCQBDD
	tuzL0j7yNaBQIiLoVnRrMOaIKOtvkIWxvLtunFMVp5Snqxn8+WvofcqPwpVlXWIfZB0vBDO7vto
	9uPzRIaku+ehfA8EkdW5gK6WwTLsxVHZZ9xGZqxUgPiSDfnS8WSJ1xE=
X-Received: by 2002:a05:600c:a14:b0:4bb:6994:abe0 with SMTP id 5b1f17b1804b1-4bb6994b7eemr9745705e9.1.1794682359704;
        Sat, 14 Nov 2026 10:52:39 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae4414sm161858265e9.9.2026.11.14.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:52:39 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Russell King <linux@armlinux.org.uk>, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: Add ARM TWD (MPCore private) watchdog driver
In-Reply-To: <db3a09f6-a560-4522-9954-8aa63eb2d5fb@roeck-us.net>
References: <20261114-arm-twd-wdt-v4-1-5a3104b36331@gmail.com>
 <db3a09f6-a560-4522-9954-8aa63eb2d5fb@roeck-us.net>
Date: Sat, 14 Nov 2026 21:52:32 +0300
Message-ID: <179468235262.1897695.7261271002700550095@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Guenter,

On Sat, Nov 14, 2026 at 07:56:12AM -0800, Guenter Roeck wrote:
> Watchdog drivers are supposed to watch the system as a whole, not on a
> per-CPU level. This patch goes way beyond the scope of a system watchdog
> driver. Per-CPU watchdogs are handled in kernel/watchdog.c. I do not think
> it is a good idea to overlay that with a second per-CPU watchdog mechanism.

Thanks, understood. Watching individual CPUs was not the intent: all the
watchdogs get the same timeout and are pinged together from the ioctl,
so the driver acts as one system watchdog. Going through every CPU only
follows from the registers being banked, and it is what made the driver
grow (hotplug state, CPU PM, the races Sashiko found).

The board needs one system watchdog and nothing per CPU: its boot loader
starts the watchdog of CPU0 only, and the SoC has no other watchdog.
Would a driver along these lines be acceptable?

- use the watchdog of CPU0 only: start, stop, ping and get_timeleft run
  there through smp_call_function_single();
- no CPU hotplug state: on 32-bit ARM CPU0 cannot be taken offline
  unless the platform allows it with cpu_can_disable(), and the driver
  would not probe if CPU0 is hotpluggable;
- the watchdogs of the other CPUs are not used, one found running at
  probe time is stopped;
- keep following clock rate changes and set the watchdog up again on
  resume;
- keep the restart handler.

Fil

