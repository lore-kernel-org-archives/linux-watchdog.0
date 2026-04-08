Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0238AC95
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Apr 2026 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644108; cv=pass; b=i5Kdf7bc9mxZe63q7erSwHJGErewtBWZhxozdg+xOImdNTnMFcmx2u9Z7WzOWjWioN42k86fNK0q0q3RT1tn6eZI37zgjiswzgmHI6Hsy+zujuhCLgIwL2JcPxYRhPnKe2AOMqcySUzYdw3gZCdBkMg86+loGAwfzevutJsmV3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644108; c=relaxed/simple;
	bh=YY4c3fuxkLuFGf6aCJIhwRJsbabPmDF632rTozVCubo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hI7uRdiDAvwoW1E0lBYLqAhmbS4fcMBc0GQW2nRoaR9yHXhilJUDvXoQdRZDH4JPRnihw11RfOePYXgIGuSkrCbo8lRgYG15IzRI1qBI6b3fia7TQfA063AFCbAqJpnQd9LZrlt7x7BuLjY46RT6e5f/NSsO4MySPUfKHavNgnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE4Jbtaf; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE4Jbtaf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2bb0fe3bbso5288942e87.3
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Apr 2026 03:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775644103; cv=none;
        d=google.com; s=arc-20240605;
        b=JK+mEKWWjbciOftjxil1RBr4BdyyvL2jvY4GwpXtB9pYF7miF+jFUPSgORdDEXCk4W
         oXgeWiaHwRQj7vEzOAho23liFw7TkqJ9JW7XN/m9RKCnyDPHCju0bK5+Pz8LrVvwQDm5
         BKGzu3+rixrXbNS8bNogjSXTcZZPhn32TxY/j6W20nBUv3QEeudXUemMZmKMbYMttUxS
         SowP4n3KqAAf6Sp097DotfCQsMeYxc2eNsVG915Zc7pnrP/xDsSqH1hlEA5DnPpHQVPX
         kcboTqnkSQcUDGMxjAz1uMBDW/gx4aqPuqo37dihJrvnjpVDLYG+wPNVL3tmb2C/sKCK
         4rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YY4c3fuxkLuFGf6aCJIhwRJsbabPmDF632rTozVCubo=;
        fh=AfV5tB6s1vlmWG6HkIpRGZ7R94z1hzhX2I7Xbhooz2I=;
        b=VhusU5dB4RY4CoZuwfhfboMIoR8pcVAUWP2hMv5/eZQbsYjrWow+wACQD09vRgHfk4
         yTGEbNMuWkZrygsqI+O0rR0U2kbBhyUmyXNxEQuhR3nnoWjrMdhYEbh15Qx5j0ceQwqD
         5Dcg3p9/ja8pX5fToBmfkG6UtpPgWrFKy8qOHj7T6TB7kqpuAi1eSBC7l8soNZP5NS8f
         W0ZCEYh6VrCbER/TJnEpOc1duJ07pj/GApKYPr/tNukqi3JlHBns3+DZ2GEJV/jdLSIh
         B3Uxecig+4be/k0KBvvsV8DXu+iMTSU/C9pzBLklCD6ughtVNjmXQTIy1W7fnYrpPYl4
         wAkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775644103; x=1776248903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY4c3fuxkLuFGf6aCJIhwRJsbabPmDF632rTozVCubo=;
        b=UE4JbtafbAyGKQmN65pp5tdqxhn9aiXEJyipSPDmLfDC86LRIuj49oqni8ZqJNdeGK
         G8OAXGnS5GIGjTeSilXD5I0omT2g/jraHJ/PUar9auox1GT55dS6OXlce5K3CzfXmeOE
         wIIjawz6Kyhq6LiSeov8JOb4WKQoj0J1P1gGZ3sqp+xkNKIZ7dEU8KZjaU8m6Sxgq00S
         7+pBoiAgogKMm6nNRhOlD6Q9bs0tCuGig8EZDs/Bd8nEyVMKnvmOwAA/DVwg+TGxAtdy
         g2ndwJ1u33blga9e+ysU26xRn9wPmaLyIbNePhLfIeT0kpW1IsVkmLE9LiExibeqQYUu
         NkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775644103; x=1776248903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YY4c3fuxkLuFGf6aCJIhwRJsbabPmDF632rTozVCubo=;
        b=YhRg3fjleJeJGA6NO/w5MqF8AALpwpDCGSVLLgSmRblhyLCECbJdI3NeACV48C8ohZ
         pNWb28lVuGGAsAPIS2ZqwRRpIT+Upo6Ibl9lU30jiqWDkvvNfROOZ6O1YRTK3NYrgJMk
         KP6o8wSROtDKaVTFDp0fvqQNUGQb5Yo2P+/C9TYP6Dvvgi9umMt2AY4kfE1DUQ5u8pB9
         25C+0ib5jktZUpnY/CxDA1+BZ3SOuL2Kqc412hTz1sQoTiIPIVFlvdeuS2UPXpp59D4B
         kqIKCsNOrxg7dMVChHZfZmSSz6/WokrGxEizKgziVAL4nZ9V57OojY9ZFbcgApeFF+GZ
         /FkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9afnrrs/8ke+sejzxcKzratmXbLOIROsr+EuEN3cAwrT9opImanFOa2Tpme6pktcYB7PREY13iK3tMo+Drg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bYaTsawo+3FHgb1FyYxNGvBnfEylxJN6LgHnddAKnY4hTglw
	LFAs/IGjIY1oK80Cc00zSAzOq0gk6cic9eVaTixhSj7vWv5h+xjy8iP5j263m+XOOVE6KQIrjvD
	8nCN6GgPwCNvMeHY5QXs+ISQTB9j4YfQ=
X-Gm-Gg: AeBDies6cn4ZdM/SE83+YZ92+LHubCv/+9K+HVnNd9ezUFV1CxraivCwVr2ECR8UU2O
	bizkgCJmCOUei1c4EHbqwSXkAUjZ9yBch/utSQkgr8ob3mxUcdf0esSQupvxkOLnbxNtLsEL3H4
	C5Z4+KlMvVHw7PEtdAOBsgQ73x4704wmHqJ/COX1+aiRMqQtox9y3HmbApL+/3O+MwvaEhrLuL5
	auRI03aVK/F65u8kMEi+bTlN13SIL0GdHJKlNiYovtBs8RdupA1N2qMAbRVm/G44pdIltfASB7J
	cewuOkIXA+Mk2yC/8LgNBtDLygsrh3SflqIQUaPNTRBwF/+3GJjKM6SMofYUScExSUdP6g==
X-Received: by 2002:a05:6512:3b8f:b0:5a2:a13e:9082 with SMTP id
 2adb3069b0e04-5a33758cb31mr7239647e87.35.1775644103036; Wed, 08 Apr 2026
 03:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310002040.417424-1-festevam@gmail.com> <85660b25-a936-44f0-95b2-3c90d559efc3@roeck-us.net>
In-Reply-To: <85660b25-a936-44f0-95b2-3c90d559efc3@roeck-us.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Apr 2026 07:28:10 -0300
X-Gm-Features: AQROBzCFLMKdn6_DPxMBZZudNOsitB-tdvZTVJRufurYW4e2dSJ5lAU_ylDmUrc
Message-ID: <CAOMZO5DFWYUPN9sPzBr-W7fy8ZbrXP7u1sx=HrmUAQVCLrsdjQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B compatible
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, heiko@sntech.de, 
	Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Mar 16, 2026 at 11:14=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On 3/9/26 17:20, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@nabladev.com>
> >
> > The RV1103B watchdog is compatible with the existing DesignWare Watchdo=
g
> > binding. Add the rockchip,rv1103b-wdt compatible string.
> >
> > Signed-off-by: Fabio Estevam <festevam@nabladev.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Could you please apply this one?
