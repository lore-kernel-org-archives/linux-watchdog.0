Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37503A0E8E
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302547; cv=none; b=Mmp9nokRR91+Y9I0bntPwJqM9e1nkXBu7JJjKru14O4IxEPrxCjgV3aE/lHilRkK4VEHNjUnJviALm2vjLP7tc/+59Po9DXGkuD+t0j1+2+KPP4FirqWIb1JripPV/Bpv+8tEVeR6SK9Gg8L6kga0Er7IZGJXWbYa9pGI8yi5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302547; c=relaxed/simple;
	bh=aq1BSjxXtT48RESqWRLyQJsVDOpgM7cZqj3oSg4pgJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoqUntTDyNnaRpOf1DR9ESbrty63qOFqOaDRsaT6IKrAM+KJsvA2D9lhj4mqshhHx60T+8GmKo8AJmYvg49KmaFDbjlcGngge9NU0/LIhxkyZGA8M3dzzeBtearJrjtz4JxWJopGc3WR0IOLJFRUoy6DtfnyA1rcuUdNulGpAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0d/ysnC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0d/ysnC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d004f135b1so13639975ad.3
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302545; x=1786907345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vZGi+iuh+YDljvOzn1g8dcCjbMnjc8Erlh5ur5ioA8=;
        b=B0d/ysnCxhAFoBWRPZshkQwJbKkrbtkTJgolNvt1OujSr41YLC+IHL+kxZdp69lNLM
         xK/3jEuP6iuhiKe1GBEnER3jHyuNGYq1jnDM+9vaZP1iE2IVefooYsjuJOG1s12gjM/R
         rcVtbORPRvR6zF+fU4HQ5G9DCHXYf6hFf3ahxz8TKwiByYgFzdetI7nmEIbjSPpBtXPb
         Q5rUybulkXVErlHXe84MD5fJGGthpUsLs5cnlmAJxEor+Sv3xixG8D5fGoPOLMTmR8sq
         mmvGqAlpEJyKMEJ88lleWeqThxwQtsfJIZ0die3bSMK9iGOcM7igdkgfycS1QJag86LA
         Db/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302545; x=1786907345;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6vZGi+iuh+YDljvOzn1g8dcCjbMnjc8Erlh5ur5ioA8=;
        b=onCcPQduR0xxNhsjVljv9svnsc2vUHWgqAykZ5KPrtodVmHSp/C8FmWLpVarf6yXHc
         JvBW3yadj1L3NdquY+BBE073G1Et38wwithvB+c2mFfnUOHA+87ZwTE77GiFxli3Du1J
         sn78mEC+aNKgx83Pc7kMyV9EBLM8E8j+vX3FzcMgDR0D7kRcfjeOfwackqUkMA4njAsn
         I7kti+OPfNT/eFDsnJenFja+ipMsq24HhjbBFjYXVsvwgcEOlMxiFj29dvZNHK6CrDcz
         kLAmtdO2jO1aa8obty5Fzohla8g951Q38fIjJHkBHkLDccOd9k4dUh5+szroKqeZ/g9u
         S7Yg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9XBEiAQPChRc0Ey6B01Xqx+F7lwNrfxdAghmkBID1kj17JRMLR09AQCMC5oHXpvpzw8f5AXd36MIC950ZQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPfagyPXBqNqYxeh048EHZRnWxM9YTtLqy6CxK6dzG2iZtj4P
	Znb/bFHr07vdj7+Pz4UX+4c7PsqvJwRknz89ebJZfJ2l0pZk9/j7B+Ll
X-Gm-Gg: AR+sD10nBCupJhk7TYF19kHU22uIGh60VY9aMH8H2WFp1q54WiJA9yjiuszqgwYuXYb
	Am3uI/XkF38ZzIwQsr4JT0UfxKyQC22NVgba/o3XU0ynX0rESi3/pUNQjRFDLECugjkY/PtsWWX
	RMKUl8lwchfireEiK0kH++nMW1MTtsN+BGbtIQjYHFrHmP1UdhXUOZiOH7qoswPGXE5L2DqqNLk
	9SqUiC2+thRzoHnvdUisiBLxY9ExJSRJefMfoPq75DTIlutNUAebYKdOj1Th+zjm9MoBWoluLad
	m2j+ujn3CwzBJbR9AGa1L29j3Mxar3AB5FJfsQ0k4RfmmDhFty2aQC6egLhBAoqosodXeNWaCXj
	dlh/yfcUcyPa0EapsDcd9AoXQkaK9Y9BTMQFJl8bgjhqivDeHbWwm3JOlpDWTMh2/qHbHvVgI3l
	Ymq5mwRH0XTRYGUy+TtiPeNUpwY7gEy6aDte/uMnZRqFeHWX1kA64dBAUCKajBpWixscOtnKz2q
	iQLRk82BSKy+zlhBfvm7DveHPsaPHgYjwl+eQ==
X-Received: by 2002:a17:902:da87:b0:2cf:4c0f:5129 with SMTP id d9443c01a7336-2d0caa03fcfmr385767855ad.17.1786302545136;
        Sun, 09 Aug 2026 12:09:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec5aac2sm36971156eec.30.2026.08.09.12.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 12:09:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ff780a8d-c164-49df-b68d-203966a16442@roeck-us.net>
Date: Sun, 9 Aug 2026 12:09:02 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] arm: dts: mediatek: mt6589: Enable toprgu reset
 controller
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>,
 linux-mediatek@lists.infradead.org, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-4-l.scorcia@gmail.com> <aniv5B4jz07mI70D@buffalo-ssd>
 <0e4dfe8b-af67-4dcf-92fc-cd564d7c3744@roeck-us.net>
 <CAORyz2+op80Tj1Ax1PD8wN9fAT5QfAev+vEPBgihvM0O-tWXPA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAORyz2+op80Tj1Ax1PD8wN9fAT5QfAev+vEPBgihvM0O-tWXPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 11:55, Luca Leonardo Scorcia wrote:
> Hi,
> I added his Signed-off tag as he provided basically this same patch in
> a separate series [1] slightly before this submission and I wanted to
> acknowledge his work. As far as I understand, this attribution is
> within the guidelines.
> 

 From Documentation/process/submitting-patches.rst:

   Any further SoBs (Signed-off-by:'s) following the author's SoB are from
   people handling and transporting the patch, but were not involved in its
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   development. SoB chains should reflect the **real** route a patch took
   ^^^^^^^^^^^
   as it was propagated to the maintainers and ultimately to Linus, with
   the first SoB entry signalling primary authorship of a single author.

I won't apply this patch anyway, so it is for others to decide if
"this attribution is within the guidelines". I stand by earlier
statement.

Thanks,
Guenter

