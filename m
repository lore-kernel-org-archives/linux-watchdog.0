Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722429;
	b=jr1SJ1uBAxX/rNd86yPXxWx+lLQyCRL6KNRH0tO64f+FUEqZeo75vWPf2E5RYtiQelkA
	 4ZoS3biB0Ss9oJuSsOESYRgQyZesLkPHvZONopBe/1fX653v963l2pgXcqWpq/nxH2U/w
	 Ir2+BF8qUgfNCrJxQkUXqCciWLQEN/PZ6HJIxLeLZWVmsi9nyU8S99l6Mide04/6e8VgX
	 n7uJPOagOoN7fMoBsDk1rzt3e5os0Yidp2A28x1dmVsqTWeI5JKhqnoRkxdLWR9lv3fVY
	 WfnF9okWYvng+LNNxuyZxQoKVUfuSKCE+TN3obrBOdLyzNWmM0OOHm/eQsJVJu15oAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Transfer-Encoding:MIME-Version:Content-Type;
	bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
	b=mZ3Dz7bjW/kzdxrChhnJeGn77cIR494kZUfbelIQUjLywQA1Nm0gpqL1gLrXscmPgB1F
	 xYjKDmaBpdU5Zj+ldS2imiHM3K4x7S6ii1lWdEYx06uwnjxdMicOn+J3tUZkbe4SW/MMk
	 NJKNT8CToGTSO9YtimZPCHJoqDneGlsHiVbFEkqUO39Al3hwOnGeZYJdBcWhY1YwunZHz
	 9QjtUW50uCe/Gz5+0ZN1ws7P1uOC2mk9hYhwxrE5pPE+o8klsc2Dk0n3wV+0Po3jwJVue
	 /rP8aEFYNJU73IZ/fbdAJTbdWGEZI9NujhpbmN2TVxc+S2hIg0odB67MHDWvi+DPKag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9d4b7Ef;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997F606D83C
	for <linux-watchdog@vger.kernel.org>; Tue,  3 Nov 2026 16:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4997F606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F9d4b7Ef
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so37404125e9.2
        for <linux-watchdog@vger.kernel.org>; Tue, 03 Nov 2026 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722428; x=1794327228; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
        b=F9d4b7EfncJF5ES2462x+Zjbhb4TYd33M/P+3Y0mSFXz0xngNNtM0a9BCDpY6aPyFn
         EccfZpdj51j50gsAn5T7iZGoF2czsnhL/CgXIRFFxaUQJ8AIy8hcQrohqa7xZ4IiyqZS
         4NOjesdM1xKIaKZRE1G5Cns2zp+BR0b0zP6LwIF7DN0YiH5hclwDOhZw1f7cUwtj1DvR
         d7GpzilbGp54raXH9QSRZdvcbKUMIbHdXFLMJKGuUnVlJj4pW78JqPgHT7fWZtj6D4e2
         +qENEHrrgxujIH3GBfoqRlRVbsXxPpJBnVFJ9CMZRaPj6XSd+FYZJhscJXOpj2oYJg8x
         0GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722428; x=1794327228;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJyyri76gw2tPYp+4QxyP3AtyJ37KOovjfoziur4IoA=;
        b=FpXmnllixZlTk/RBYzQJLbK69tcx409mauIQWdn1EkeuF8dWNJ/0OJP26BjyCBO7PI
         EY9wlsymM9h6YofdePGQFjcpCGtrp7+RM83SAeVaHjIVPz9Y2nmXKvplf2wruluA7lDO
         JmMn3OZ8EEP3ZySc87T+mwS2n/vNAiC+480/ASiEkKlaLPC3CfdQc2rA9qhmumkNXqql
         KwhevomQcWZvcvFxIucaLdSDRCM184lPqSLcXDaVgCDhZJxnDC9YD9kTpk11J9MA0UjA
         WJK0usc8H0TisxNyhwsEU8CLBU1xD03ldgdJ6rSNqVMi8AjuHBeRJClVqGhOu7zADWKR
         YJZw==
X-Forwarded-Encrypted: i=1; AKwUvBxlH6N4jCLKyxprVFpUqCH0FhTn8C6sjHxKl8HeYuLvCpsvERz8JLQiz7a/gkgL73hGjn1Nz++uPBiGDJA7dw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZT3xzMeuEqGjTJnUp7+lT83Di4k12TxDH5goj11stqnxtTnfk
	DNw05kb1mvUhsKXyr7dlCozSS6d60peeC7Wqu3vCkAi+QwODHgc52IbB
X-Gm-Gg: AYBFou2C97FJ90lCvksSnX5NimnpAiie7BkeUBW+7/GJ3MoP/cuKkI1L/VwmxVoNmFB
	nNgS870WcJjEq/YnlMFEsjaA03PF88tdml1KqNmQ9VRI2iFZaBeDVzmMEbjQhA1TSibdsNlu5MB
	3kE6Iq2dUuzwCavimIkZjeAFTUfHfNyZ3cfYFbQcV6nS/nhia5tRmr9Zw6v9dulfZ8nT+WcJ8VD
	aC4tGt7SEKcUtrfxRnPpRuKTuvFvrQLZuz7kvCfQcS1Ou4p2iMsULUEZritV8ugh2/I8vPdP4/2
	C8FpCqK7pz/YMtTg7Uq7qDeahA9L/hjjd0Fi5+GaqRpqKOesTufjbBTZwM68OF6173Ug86nOXA2
	gCYM7UZdYLK71bw1ySZIsVMb8Q6iJT8XQ6Tg4nc5gxvoVHSFFm7y+a3ytce52YeEeVrbOGmoh7K
	Qa0UOAl7nShAVSD0SG5mOZi0sVXRnMMGstCkNcktzS7lh2FyelX2JxSaT08vCEhFdzw6yOkLlB+
	54E/eMGDkpwwndYo5qMtu4rfTjeCJzbPIKFw/BbHIlabE/lVBkppMH2BK9hI4L664YKke9J1aTD
	V5HDnFHDdExp1dvnRapJSBrtr0qw7fEaOg7NBjwahpsQ6IqIyY2e/j9HFptSM4axc2LLujsD5Yp
	A9BjKJwPWS8zppg==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr306531505e9.13.1793722427449;
        Tue, 03 Nov 2026 08:13:47 -0800 (PST)
Received: from [127.0.1.1] (ppp91-78-241-225.pppoe.mtu-net.ru. [91.78.241.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm24419506f8f.15.2026.11.03.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:13:46 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org
Subject:
 Re: [PATCH v3 07/11] watchdog: Add ARM TWD (MPCore private) watchdog driver
In-Reply-To: <004d4007-d049-4257-97e7-bf7f197ae3a8@roeck-us.net>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <20261013-b4-cs75xx-s2-v3-7-181bb0d23f4c@gmail.com>
 <004d4007-d049-4257-97e7-bf7f197ae3a8@roeck-us.net>
Date: Wed, 04 Nov 2026 02:13:37 +1000
Message-ID: <179372241749.1222507.6207957568716226558@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

Hi Guenter,

On Mon, Oct 19, 2026 at 06:46:41PM -0700, Guenter Roeck wrote:
> The issues raised by Sashiko will need to be addressed, or you'll need
> to explain why they are non-issues.

Thanks for having a look. All three are real and are fixed in the next
version:

1. cpus_read_lock() in the clock notifier (lock inversion with CPU
   hotplug through cpufreq): the driver no longer takes cpus_read_lock()
   anywhere. The armed state and the rate are published with
   WRITE_ONCE() and applied with on_each_cpu(); a CPU coming online
   meanwhile either sees the new values in its hotplug callback or is
   reached by on_each_cpu().

2. armed set after on_each_cpu() in start, racing with a rate change:
   the flag is now set first, and the start path and the clock notifier
   each have a full barrier between their store and their load, so
   either the watchdog is started with the new rate or the notifier sees
   it armed and reloads it.

3. Watchdog state lost in a deep idle state: a CPU PM notifier sets the
   watchdog of the CPU up again on CPU_PM_EXIT/CPU_PM_ENTER_FAILED when
   the device is active and the watchdog mode bit is gone. It does not
   reload a watchdog that kept running, so idle exits do not count as
   pings.

The earlier Sashiko points (prescaler of a watchdog left running by the
boot loader, rate changes, resume) were handled in v2 and v3.

As the driver is not specific to the Cortina SoC, the next version will
be a standalone patch to you and Wim instead of part of the CS75xx
series. It will be sent after v7.4-rc1.

Fil

