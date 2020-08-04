Return-Path: <SRS0=khzt=BO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8DC433E0
	for <linux-watchdog@archiver.kernel.org>; Tue,  4 Aug 2020 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06A82086A
	for <linux-watchdog@archiver.kernel.org>; Tue,  4 Aug 2020 14:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw7So52c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHDOlQ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDOlP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Aug 2020 10:41:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011CC06174A;
        Tue,  4 Aug 2020 07:41:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g19so28893585ejc.9;
        Tue, 04 Aug 2020 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=87hnD9JrBDJRPVBY883odDAkls7fmYD09QZfbVG4/SI=;
        b=Uw7So52cErg3nOM+7sLN/i0/alg0dvrcImgLdap4d2r0CORGmRXvU3pB8DJO+oQvXe
         65eXltWRUmX0mImXAAjpQ4OOCyXD4iaawal1FpncODiq6EzrkgStPwXLCqfPM17dlIHM
         HOSFGq1mryboFWrBS3sP6UbqAz5m/ueHWkWS4itLMCqo2bMot0TvTL3ojJCnYLtXW7vP
         GiEyFgue5ue/zuXBEu/DbokhY7qhA5r60h540ju4hHsDH6rBTwySCSyvM1HCBGup/aUk
         P8BNvwWc50zTE4lG16eTXo2/3DZKqN7MdZfuKIOzXgjFOr8TLTYONHuU6YzTGO5VEsVj
         BUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=87hnD9JrBDJRPVBY883odDAkls7fmYD09QZfbVG4/SI=;
        b=TzSs+LlHcwQUtnUpPcQrl6H0Phss5GqRyCdIIDrx1jYGwXL4MwnHLTJvZSlDyuS6B7
         K1mGGctKfL+WHtt7pTpxH7/Z9YqmFASUsarl99sOQ0taOmszlCZl8LXPYTselQb89urW
         dbLIG3Wr/cWS8dYV18zhEVQLTGetTQ3oiRxnvl5TxJGuTcPxC2lWjzSxdTPBcAOu87pP
         ss7SF0Ys1n//WW2m8RyUCE1BUl9nBAKj43KibsnujR3ufylWYkQw6I1GiyIThP5GWZs7
         iuwEN91HS7Lt2wfxO6J1qSdqCpPWLgLPP+4Jwgsb4KGpCdHaCPeH42+yPw1hUHMoguXl
         DBFw==
X-Gm-Message-State: AOAM531g0m0LWF3ouaQP5MDJL6ff5YzRYt5ozokt03ePSzjg1UHQV37y
        3Gq6hg69gg42uFeEW8duVYoXZdAzGVVWJ83f7K4uo4PGtw==
X-Google-Smtp-Source: ABdhPJzttZJEs+GVvEDCoZ0Tmn/Nlqpv1xJFcJJLc3RMU8xG9iyx11Kw/8QMs3LSc+VXN0T+EJSHuhUvGwLqmrwaq/U=
X-Received: by 2002:a17:907:398:: with SMTP id ss24mr5558708ejb.311.1596552073372;
 Tue, 04 Aug 2020 07:41:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naveen Kumar P <naveenkumar.parna@gmail.com>
Date:   Tue, 4 Aug 2020 20:11:02 +0530
Message-ID: <CAMciSVWzH3fuo8eStwRUwGJ+VsJjctLucOZo-EVx07ktXzObFA@mail.gmail.com>
Subject: iTCO watchdog last reboot reason?
To:     linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

[ Please keep me in CC as I'm not subscribed to the list]

Hi everyone,

I enabled the iTCO watchdog in my Linux system.

sudo cat /dev/watchdog perfectly reboots my system. But, is there a
way to find out on each boot if the machine was rebooted due to a
watchdog timeout or not?

Any ideas?


Thanks,
Naveen
